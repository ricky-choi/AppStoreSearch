//
//  CoreDataManager.swift
//  RecentsService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    enum ResourceName {
        static let store = "Recents"
        static let entity = "SearchTerm"
        
        static let attr_term = "term"
        static let attr_date = "date"
    }
    
    let memoryOnly: Bool
    
    init(memoryOnly: Bool = false) {
        self.memoryOnly = memoryOnly
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let bundle = Bundle(for: CoreDataManager.self)
        let modelURL = bundle.url(forResource: ResourceName.store, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        
        let container = NSPersistentContainer(name: ResourceName.store, managedObjectModel: managedObjectModel)
        
        if memoryOnly {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func add(term: String, date: Date = .now) {
        let trimmedTerm = term.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTerm.isEmpty else { return }
        
        let context = persistentContainer.viewContext
        
        defer {
            try? context.save()
        }
        
        if let exist = find(term: trimmedTerm) {
            exist.setValue(date, forKey: ResourceName.attr_date)
        } else {
            let entity = NSEntityDescription.entity(forEntityName: ResourceName.entity, in: context)!
            let searchTerm = NSManagedObject(entity: entity, insertInto: context)
            searchTerm.setValue(trimmedTerm, forKey: ResourceName.attr_term)
            searchTerm.setValue(date, forKey: ResourceName.attr_date)
        }
    }
    
    func find(term: String) -> NSManagedObject? {
        guard !term.isEmpty else { return nil }
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: ResourceName.entity)
        
        let predicate = NSPredicate(format: "\(ResourceName.attr_term) == %@", term)
        fetchRequest.predicate = predicate
        
        let searchTerms = try? context.fetch(fetchRequest)
        return searchTerms?.first
    }
    
    func fetchAll() throws -> [String] {
        return try fetchTerm("")
    }
    
    func fetchTerm(_ term: String) throws -> [String] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: ResourceName.entity)
        
        let dateSort = NSSortDescriptor(key: ResourceName.attr_date, ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        if !term.isEmpty {
            let predicate = NSPredicate(format: "\(ResourceName.attr_term) CONTAINS[c] %@", term)
            fetchRequest.predicate = predicate
        }
        
        let searchTerms = try context.fetch(fetchRequest).map { $0.value(forKey: ResourceName.attr_term) as! String }
        return searchTerms
    }
    
    func clear() throws {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ResourceName.entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        try context.save()
    }
}
