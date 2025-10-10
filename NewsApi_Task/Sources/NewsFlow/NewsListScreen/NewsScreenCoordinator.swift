//
//  NewsScreenCoordinator.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit

final class NewsScreenCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinator] = []
    let id = ScreenId.newsList.rawValue
    
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
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
    }
    
    func addCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0.id == coordinator.id })
        childCoordinators.append(coordinator)
    }
    
    func openDetails(for item: Article) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, article: item)
        addCoordinator(detailsCoordinator)
        detailsCoordinator.start()
    }
}
