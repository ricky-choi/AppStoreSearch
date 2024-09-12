//
//  AppStoreRepository.swift
//  AppStoreService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

protocol AppStoreRepository {
    
    func search(term: String) async throws -> SearchResultDTO
}
