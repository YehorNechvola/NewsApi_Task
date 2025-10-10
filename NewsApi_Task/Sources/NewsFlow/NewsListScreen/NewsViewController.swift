//
//  NewsViewController.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: NewsListViewModelProtocol!
    
    // MARK: - UI
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 140
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
        viewModel.onLoad()
    }
}

// MARK: - Setup
private extension NewsViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        title = "News"
        
        setupSearchController()
        setupTableViewConstraints()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search articles..."
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupTableViewConstraints() {
        view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func bind() {
        viewModel.atachOutput(
            .init(onLoad: { [weak self] in self?.newsTableView.reloadData() },
                  onAddNewArticles: { [weak self] in self?.newsTableView.reloadData() },
                  onError: { print("Error") }
                 )
        )
    }
}

// MARK: - UISearchResultsUpdating
extension NewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
        cell.configure(with: viewModel.newsList[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapOnNews(by: indexPath.row)
    }
}
