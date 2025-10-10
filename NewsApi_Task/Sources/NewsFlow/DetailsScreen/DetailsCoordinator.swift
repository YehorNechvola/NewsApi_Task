//
//  DetailsCoordinator.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//


import UIKit

final class DetailsCoordinator: Coordinator {
    
    // MARK: - Properties
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinator] = []
    private let article: Article
    let id = ScreenId.details.rawValue
    
    // MARK: - Init
    init(navigationController: UINavigationController, article: Article) {
        self.navigationController = navigationController
        self.article = article
    }
    
    // MARK: - Methods
    func start() {
        let viewController = DetailsViewController()
        let viewModel = DetailsViewModel(article: article)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func addCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0.id == coordinator.id })
        childCoordinators.append(coordinator)
    }
}
