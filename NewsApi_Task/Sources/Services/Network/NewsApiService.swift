//
//  NewsApiService.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import Foundation

protocol NewsApiServiceProtocol {
    func getNewsList(completion: @escaping (Result<NewsResponse, CustomError>) -> Void)
}

final class NewsApiService: NewsApiServiceProtocol {
    
    // MARK: - Path
    private enum Path {
        case getNewsList
        
        var path: String {
            switch self {
            case .getNewsList:
                return Link.newsUrl + Link.apiKey
            }
        }
    }
    
    // MARK: - Properties
    private let baseRequestService: BaseRequestServiceProtocol
    
    // MARK: - Init
    init(baseRequestService: BaseRequestServiceProtocol) {
        self.baseRequestService = baseRequestService
    }
    
    // MARK: - Protocol Methods
    func getNewsList(completion: @escaping (Result<NewsResponse, CustomError>) -> Void) {
        let url = URL(string: Path.getNewsList.path)
        baseRequestService.getDataModel(url: url, model: NewsResponse.self) { result in
            completion(result)
        }
    }
}
