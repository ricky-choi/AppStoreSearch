//
//  TestHelper.swift
//  AppStoreServiceTests
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation
@testable import AppStoreService

class MockAppStoreRepository: AppStoreRepository {
    
    var searchResults: [AppDTO] = []
    
    func search(term: String) async throws -> SearchResultDTO {
        return .init(
            resultCount: searchResults.count,
            results: searchResults
        )
    }
}

extension AppDTO {
    
    static func makeApp(appId: Int, appName: String) -> AppDTO {
        return .init(
            artistId: 0,
            artistName: "",
            artworkUrl100: "",
            averageUserRating: 0,
            bundleId: "",
            description: "",
            formattedPrice: "",
            minimumOsVersion: "",
            price: 0,
            screenshotUrls: [],
            sellerName: "",
            trackId: appId,
            trackName: appName,
            version: "",
            userRatingCount: 0
        )
    }
}
