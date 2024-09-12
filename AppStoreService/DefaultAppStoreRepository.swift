//
//  DefaultAppStoreRepository.swift
//  AppStoreService
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation

class DefaultAppStoreRepository: AppStoreRepository {
    
    let endpoint: URL
    
    public init(endpoint: URL = URL(string: "https://itunes.apple.com/search")!) {
        self.endpoint = endpoint
    }
    
    private func makeURL(
        term: String,
        country: String = "kr",
        media: String = "software",
        lang: String = "ko_kr",
        limit: Int = 20
    ) -> URL? {
        var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            .init(name: "term", value: term),
            .init(name: "country", value: country),
            .init(name: "media", value: media),
            .init(name: "lang", value: lang),
            .init(name: "limit", value: "\(limit)"),
        ]
        return urlComponents?.url
    }
    
    func search(term: String) async throws -> SearchResultDTO {
        guard let requestURL = makeURL(term: term) else { throw NetworkError.invalidRequest}
        
        let (data, response) = try await URLSession.shared.data(from: requestURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noHTTPURLResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.serverError
        }
        
        let dto = try JSONDecoder().decode(SearchResultDTO.self, from: data)
        return dto
    }
}

enum NetworkError: LocalizedError {
    case invalidRequest
    case noHTTPURLResponse
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "올바르지 않은 요청"
        case .noHTTPURLResponse:
            return "잘못된 응답"
        case .serverError:
            return "서버 에러"
        }
    }
}
