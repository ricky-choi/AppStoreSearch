//
//  AppStoreUITests.swift
//  AppStoreUITests
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import XCTest
import Combine
@testable import AppStoreUI

final class AppStoreUITests: XCTestCase {
    
    var subscriptions: Set<AnyCancellable>!
    var viewModel: MockSearchViewModel!

    override func setUpWithError() throws {
        subscriptions = []
        viewModel = MockSearchViewModel()
    }

    override func tearDownWithError() throws {
        subscriptions = nil
        viewModel = nil
    }

    func test_search_app() throws {
        let app = AppUIModel(
            appName: "App",
            appIconURL: "",
            appDescription: "",
            appScreenshotURLs: [],
            star: 0,
            starCount: ""
        )
        
        viewModel.searchResults = [app]
        viewModel.search(term: "any")
        
        XCTAssertTrue(viewModel.isCalledSearch)
        
        let expectation = XCTestExpectation()
        
        viewModel.apps
            .sink { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first, app)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation])
    }

    func test_recents_app() throws {
        let recent = "Favorite"
        
        viewModel.recentResults = [recent]
        viewModel.recent(term: "Fav")
        
        XCTAssertTrue(viewModel.isCalledRecent)
        
        let expectation = XCTestExpectation()
        
        viewModel.recents
            .sink { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first, recent)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation])
    }
}

class MockSearchViewModel: SearchViewModel {
    
    var isCalledSearch: Bool = false
    var isCalledRecent: Bool = false
    
    var searchResults: [AppUIModel] = []
    var recentResults: [RecentUIModel] = []
    
    func search(term: String) {
        isCalledSearch = true
    }
    
    func recent(term: String) {
        isCalledRecent = true
    }
    
    var apps: AnyPublisher<[AppUIModel], Never> {
        Just(searchResults).eraseToAnyPublisher()
    }
    
    var recents: AnyPublisher<[RecentUIModel], Never> {
        Just(recentResults).eraseToAnyPublisher()
    }
    
}
