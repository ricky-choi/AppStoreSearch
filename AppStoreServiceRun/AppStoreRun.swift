//
//  AppStoreRun.swift
//  AppStoreServiceRun
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation
import ArgumentParser
import AppStoreService

@main
struct AppStoreRun: AsyncParsableCommand {
    
    @Argument(help: "검색어")
    var term: String
    
    func run() async throws {
        let results = try await AppStore().search(term: term)
        print(results)
    }
}
