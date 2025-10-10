//
//  NewsListViewModel.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import Foundation

protocol NewsListViewModelProtocol {
    var searchedNewsList: [Article] { get }
    func atachOutput(_ output: NewsListViewModel.Output)
    func onLoad()
    func didTapOnNews(by index: Int)
    func searchNews(by text: String)
    func refreshNews()
}

final class NewsListViewModel: NewsListViewModelProtocol {
    
    // MARK: - Output
    struct Output {
        var onLoading: () -> Void
        var onLoad: () -> Void
        var onRefresh: () -> Void
        var onError: () -> Void
    }
    
    // MARK: - Properties
    weak var coordinator: NewsScreenCoordinator!
    private var output: Output!
    private let newsService: NewsApiServiceProtocol
    private var allNewsList: [Article] = []
    var searchedNewsList: [Article] = []
    
    private var searchText: String = "" {
           didSet {
               debounceSearch()
           }
       }
    
    private var searchWorkItem: DispatchWorkItem?
    
    // MARK: - Init
    init(newsService: NewsApiServiceProtocol) {
        self.newsService = newsService
    }
    
    // MARK: - Protocol Methods
    func atachOutput(_ output: Output) {
        self.output = output
    }
    
    func onLoad() {
        output.onLoading()
        newsService.getNewsList { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.allNewsList = response.articles
                    self?.searchedNewsList = response.articles
                    self?.output.onLoad()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapOnNews(by index: Int) {
        let article = allNewsList[index]
        coordinator.openDetails(for: article)
    }
    
    func searchNews(by text: String) {
        searchText = text
    }
    
    func refreshNews() {
        output.onRefresh()
        self.onLoad()
    }
    
    // MARK: - Private Methods
    private func debounceSearch() {
        searchWorkItem?.cancel()
        
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            filterNews()
            return
        }
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.filterNews()
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
    }
    
    private func filterNews() {
        let text = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if text.isEmpty {
            searchedNewsList = allNewsList
        } else {
            searchedNewsList = allNewsList.filter { $0.title.lowercased().contains(text) }
        }
        
        DispatchQueue.main.async {
            self.output.onLoad()
        }
    }
}
