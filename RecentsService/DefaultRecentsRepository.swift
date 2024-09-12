//
//  DefaultRecentsRepository.swift
//  RecentsService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

class DefaultRecentsRepository: RecentsRepository {
    
    let coreDataManager = CoreDataManager()
    
    func recents(term: String) throws -> [String] {
        return try coreDataManager.fetchTerm(term)
    }
    
    func recentsAll() throws -> [String] {
        return try coreDataManager.fetchAll()
    }
    
    func add(term: String) {
        coreDataManager.add(term: term)
    }
    
    func clear() throws {
        try coreDataManager.clear()
    }
}
