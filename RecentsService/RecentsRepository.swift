//
//  RecentsRepository.swift
//  RecentsService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

protocol RecentsRepository {
    
    func recents(term: String) throws -> [String]
    func recentsAll() throws -> [String]
    func add(term: String)
    func clear() throws
}
