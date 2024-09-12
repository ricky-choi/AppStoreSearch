//
//  DefaultSearchViewModel.swift
//  AppStoreSearch
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation
import Combine
import AppStoreUI
import AppStoreService
import RecentsService

class DefaultSearchViewModel: SearchViewModel {
    
    let appStoreService = AppStore()
    let recentsService = RecentsService()
    
    private let appsSubject: CurrentValueSubject<[AppUIModel], Never> = .init([])
    private let recentsSubject: CurrentValueSubject<[RecentUIModel], Never> = .init([])
    
    // MARK: - Input
    
    func search(term: String) {
        recentsService.add(term: term)
        
        Task {
            do {
                let results = try await appStoreService.search(term: term)
                let appUIModels = results.map { $0.uiModel }
                appsSubject.send(appUIModels)
            } catch {
                print("Error ->", error)
            }
        }
    }
    
    func recent(term: String) {
        let results = recentsService.recents(term: term)
        recentsSubject.send(results)
    }
    
    // MARK: - Output
    
    var apps: AnyPublisher<[AppUIModel], Never> {
        appsSubject.eraseToAnyPublisher()
    }
    
    var recents: AnyPublisher<[RecentUIModel], Never> {
        recentsSubject.eraseToAnyPublisher()
    }
}

extension AppDTO {
    var uiModel: AppUIModel {
        return AppUIModel(
            appName: trackName,
            appIconURL: artworkUrl100,
            appDescription: description,
            appScreenshotURLs: screenshotUrls,
            star: averageUserRating,
            starCount: "\(userRatingCount)"
        )
    }
}
