//
//  MainCoordinator.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit

final class MainCoordinator {
    
    // MARK: - Properties
    private let navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let viewController = NewsViewController()
        let baseRequestService = BaseRequestService()
        let newsService = NewsApiService(baseRequestService: baseRequestService)
        let viewModel = NewsListViewModel(newsService: newsService)
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
    }
}
