//
//  RecentsServiceTests.swift
//  RecentsServiceTests
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import XCTest
import CoreData
@testable import RecentsService

class RecentsServiceTests: XCTestCase {
    
    let coreDataManager = CoreDataManager(memoryOnly: true)

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        
    }

    func test_fetch_all() throws {
        
        coreDataManager.add(term: "kakao", date: .now)
        coreDataManager.add(term: "kakaobank", date: .now + 1)
        
        let results = try coreDataManager.fetchAll()
        
        XCTAssertEqual(results.count, 2)
        XCTAssertEqual(results[0], "kakaobank")
        XCTAssertEqual(results[1], "kakao")
    }
    
    func test_fetch_all_sort() throws {
        
        coreDataManager.add(term: "kakao", date: .now)
        coreDataManager.add(term: "kakaobank", date: .now + 1)
        coreDataManager.add(term: "kakaomobility", date: .now - 1)
        
        let results = try coreDataManager.fetchAll()
        
        XCTAssertEqual(results.count, 3)
        XCTAssertEqual(results[0], "kakaobank")
        XCTAssertEqual(results[1], "kakao")
        XCTAssertEqual(results[2], "kakaomobility")
    }
    
    func test_fetch_with_term() throws {
        let term = "kakao"
        
        coreDataManager.add(term: "kakao", date: .now)
        coreDataManager.add(term: "kakaobank", date: .now + 1)
        coreDataManager.add(term: "kakaomobility", date: .now - 1)
        coreDataManager.add(term: "naver")
        
        let results = try coreDataManager.fetchTerm(term)
        
        XCTAssertEqual(results.count, 3)
    }
    
    func test_add_term() throws {
        coreDataManager.add(term: "kakao", date: .now)
        coreDataManager.add(term: "kakaobank", date: .now + 1)
        coreDataManager.add(term: "kakaomobility", date: .now + 2)
        coreDataManager.add(term: "kakao", date: .now + 3)
        
        let results = try coreDataManager.fetchAll()
        let first = results.first!
        
        XCTAssertEqual(first, "kakao")
        XCTAssertEqual(results.count, 3)
    }
    
    func test_add_empty_notavailable() throws {
        coreDataManager.add(term: "")
        
        let results = try coreDataManager.fetchAll()
        
        XCTAssertEqual(results.count, 0)
    }
    
    func test_add_empty2_notavailable() throws {
        coreDataManager.add(term: " ")
        
        let results = try coreDataManager.fetchAll()
        
        XCTAssertEqual(results.count, 0)
    }

}
