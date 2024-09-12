//
//  UIModel.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation


public typealias RecentUIModel = String

public struct AppUIModel: Hashable {
    let appName: String
    let appIconURL: String
    let appDescription: String
    let appScreenshotURLs: [String]
    let star: Float
    let starCount: String
    
    public init(
        appName: String,
        appIconURL: String,
        appDescription: String,
        appScreenshotURLs: [String],
        star: Float,
        starCount: String
    ) {
        self.appName = appName
        self.appIconURL = appIconURL
        self.appDescription = appDescription
        self.appScreenshotURLs = appScreenshotURLs
        self.star = star
        self.starCount = starCount
    }
}

public enum SearchSection: Hashable {
    case recents
    case apps
}

public enum SearchItem: Hashable {
    case recent(RecentUIModel)
    case app(AppUIModel)
}
