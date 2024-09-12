//
//  RecentsService.swift
//  RecentsService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

public class RecentsService {
    let repository = DefaultRecentsRepository()
    
    public init() {}
    
    public func add(term: String) {
        repository.add(term: term)
    }
    
    public func recentsAll() -> [String] {
        if let results = try? repository.recentsAll() {
            return results
        } else {
            return []
        }
    }
    
    public func recents(term: String) -> [String] {
        if let results = try? repository.recents(term: term) {
            return results
        } else {
            return []
        }
    }
    
    public func clear() {
        try? repository.clear()
    }
}
