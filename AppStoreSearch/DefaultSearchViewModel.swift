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
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    
    // MARK: - Input
    
    func search(term: String) {
        recentsService.add(term: term)
        
        Task {
            do {
                isLoadingSubject.send(true)
                
                let results = try await appStoreService.search(term: term)
                let appUIModels = results.map { $0.uiModel }
                appsSubject.send(appUIModels)
                
                isLoadingSubject.send(false)
            } catch {
                print("Error ->", error)
                isLoadingSubject.send(false)
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
    
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
}

extension AppDTO {
    var uiModel: AppUIModel {
        
        func format(number: Int) -> String {
            if number >= 10_000 {
                let man = number / 10_000
                let thousand = (number % 10_000) / 1_000
                
                if thousand > 0 {
                    return "\(man).\(thousand)만"
                } else {
                    return "\(man)만"
                }
            } else if number >= 1_000 {
                let thousand = number / 1_000
                let hundred = (number % 1_000) / 100
                if hundred > 0 {
                    return "\(thousand).\(hundred)천"
                } else {
                    return "\(thousand)천"
                }
            } else {
                return "\(number)"
            }
        }
        
        return AppUIModel(
            appName: trackName,
            appIconURL: artworkUrl100,
            appDescription: description,
            appScreenshotURLs: screenshotUrls,
            star: averageUserRating,
            starCount: format(number: userRatingCount)
        )
    }
}
