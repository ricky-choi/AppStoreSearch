//
//  AppDTO.swift
//  AppStoreService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

public struct AppDTO: Decodable, Equatable {
    
    let artistId: Int
    let artistName: String
    let artworkUrl100: String
    let artworkUrl512: String
    let averageUserRating: Float
    let bundleId: String
    let contentAdvisoryRating: String
    let description: String
    let formattedPrice: String
    let languageCodesISO2A: [String]
    let minimumOsVersion: String
    let price: Float
    let primaryGenreName: String
    let releaseNotes: String
    let screenshotUrls: [String]
    let sellerName: String
    let trackId: Int
    let trackName: String
    let trackViewUrl: String
    let version: String
}

struct SearchResultDTO: Decodable {
    
    let resultCount: Int
    let results: [AppDTO]
}
