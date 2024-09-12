//
//  AppStoreServiceTests.swift
//  AppStoreServiceTests
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import XCTest
@testable import AppStoreService

class AppStoreServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_search_term() async throws {
        let kakaoBank = AppDTO.makeApp(appId: 1, appName: "카카오뱅크")
        let kakaoTalk = AppDTO.makeApp(appId: 2, appName: "카카오톡")
        
        let repository = MockAppStoreRepository()
        repository.searchResults = [kakaoBank, kakaoTalk]
        
        let result = try await repository.search(term: "카카오")
        
        XCTAssertEqual(result.resultCount, 2)
        XCTAssertEqual(result.results[0], kakaoBank)
        XCTAssertEqual(result.results[1], kakaoTalk)
    }
    
    func test_search_term_empty() async throws {
        let repository = MockAppStoreRepository()
        
        let result = try await repository.search(term: "")
        
        XCTAssertEqual(result.resultCount, 0)
    }
}
