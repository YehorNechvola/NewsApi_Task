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
    
    private lazy var refreshControl: UIRefreshControl =  {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = Constants.rowHeight
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
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
        title = Constants.title
        
        setupSearchController()
        setupTableViewConstraints()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchPlaceholder
        
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
            .init(onLoading: { [weak self] in
                self?.refreshControl.beginRefreshing() },
                  onLoad: { [weak self] in
                      self?.newsTableView.reloadData()
                      self?.refreshControl.endRefreshing()
                  },
                  onRefresh: { [weak self] in
                      self?.searchController.searchBar.text = ""
                  },
                  onError: { [weak self] in
                      self?.refreshControl.endRefreshing()
                  }
                 )
        )
    }
    
    // MARK: - Actions
    @objc func didPullToRefresh() {
        viewModel.refreshNews()
    }
}

// MARK: - UISearchResultsUpdating
extension NewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchNews(by: searchController.searchBar.text ?? "")
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchedNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.id, for: indexPath) as! ArticleTableViewCell
        cell.configure(with: viewModel.searchedNewsList[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapOnNews(by: indexPath.row)
    }
}

// MARK: - Constants
extension NewsViewController {
    enum Constants {
        static let title = "News"
        static let rowHeight: CGFloat = 140
        
        static let searchPlaceholder = "Search articles..."
    }
}
