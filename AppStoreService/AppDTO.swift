//
//  AppDTO.swift
//  AppStoreService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

public struct AppDTO: Decodable, Equatable {
    
    public let artistId: Int
    public let artistName: String
    public let artworkUrl100: String
    public let artworkUrl512: String
    public let averageUserRating: Float
    public let bundleId: String
    public let contentAdvisoryRating: String
    public let description: String
    public let formattedPrice: String
    public let languageCodesISO2A: [String]
    public let minimumOsVersion: String
    public let price: Float
    public let primaryGenreName: String
    public let releaseNotes: String
    public let screenshotUrls: [String]
    public let sellerName: String
    public let trackId: Int
    public let trackName: String
    public let trackViewUrl: String
    public let version: String
    public let userRatingCount: Int
}

struct SearchResultDTO: Decodable {
    
    let resultCount: Int
    let results: [AppDTO]
}
