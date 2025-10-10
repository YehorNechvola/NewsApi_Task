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
    func onLoad()
    func didTapOnNews(by index: Int)
    func searchNews(by text: String)
}

final class NewsListViewModel: NewsListViewModelProtocol {
    
    // MARK: - Output
    struct Output {
        var onLoad: () -> Void
        var onAddNewArticles: () -> Void
        var onError: () -> Void
    }
    
    // MARK: - Properties
    weak var coordinator: NewsScreenCoordinator!
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
    
    func onLoad() {
        newsService.getNewsList { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.newsList = response.articles
                    self?.output.onLoad()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapOnNews(by index: Int) {
        let article = newsList[index]
        coordinator.openDetails(for: article)
    }
    
    func searchNews(by text: String) {
    
    }
}
