//
//  NewsListViewModel.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import Foundation

protocol NewsListViewModelProtocol {
    var newsList: [Article] { get }
    func atachOutput(_ output: NewsListViewModel.Output)
    func fetchNews()
    func didTapOnNews()
    func searchNews(by text: String)
}

final class NewsListViewModel: NewsListViewModelProtocol {
    
    // MARK: - Output
    struct Output {
        var onLoading: (() -> Void)
        var onAddNewArticles: (() -> Void)
        var onError: (() -> Void)
    }
    
    // MARK: - Properties
    private var output: Output!
    private let newsService: NewsApiServiceProtocol
    var newsList: [Article] = []
    private var searchedNewsList: [Article] = []
    
    
    // MARK: - Init
    init(newsService: NewsApiServiceProtocol) {
        self.newsService = newsService
    }
    
    // MARK: - Protocol Methods
    func atachOutput(_ output: Output) {
        self.output = output
    }
    
    func fetchNews() {
        newsService.getNewsList { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.newsList = response.articles
                    self?.output.onLoading()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapOnNews() {
        
    }
    
    func searchNews(by text: String) {
    
    }
}
