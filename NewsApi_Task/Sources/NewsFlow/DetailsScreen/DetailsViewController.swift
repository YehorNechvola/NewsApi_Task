//
//  DetailsViewController.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailsViewModelProtocol!
    
    // MARK: - UI Elements
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [articleImageView, titleLabel, descriptionTextView])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        bind()
        viewModel.onLoad()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200),
            articleImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    // MARK: - Binding
    private func bind() {
        viewModel.atachOutput(.init(onLoad: { [weak self] in
            guard let self else { return }
            configure(with: viewModel.article)
        }))
    }
    
    // MARK: - Configure
    private func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionTextView.text = article.description
        let imagePlaceholder: UIImage? = UIImage(systemName: "photo")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        if let urlString = article.urlToImage {
            articleImageView.downloadImage(url: urlString, placeholder: imagePlaceholder)
        } else {
            articleImageView.image = imagePlaceholder
        }
    }
}
