//
//  SearchViewModel.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation
import Combine

public protocol SearchViewModelInput {
    func search(term: String)
    func recent(term: String)
}

public protocol SearchViewModelOutput {
    var apps: AnyPublisher<[AppUIModel], Never> { get }
    var recents: AnyPublisher<[RecentUIModel], Never> { get }
    
    var isLoading: AnyPublisher<Bool, Never> { get }
}

public protocol SearchViewModel: SearchViewModelInput, SearchViewModelOutput {}
