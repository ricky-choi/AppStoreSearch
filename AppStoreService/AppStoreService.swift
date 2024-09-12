//
//  AppStoreService.swift
//  AppStoreService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

public class AppStore {
    
    let repository = DefaultAppStoreRepository()
    
    public init() {}
    
    public func search(term: String) async throws -> [AppDTO] {        
        let result = try await repository.search(term: term)
        return result.results
    }
}
