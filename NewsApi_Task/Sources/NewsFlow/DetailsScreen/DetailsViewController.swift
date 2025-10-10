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
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: Constants.descriptionFontSize)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textContainerInset = Constants.textViewInset
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [articleImageView, titleLabel, descriptionTextView])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
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
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.verticalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.horizontalPadding),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: Constants.descriptionHeight),
            articleImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
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

// MARK: - Constant
extension DetailsViewController {
    enum Constants {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 16
        static let stackSpacing: CGFloat = 12
        
        static let imageCornerRadius: CGFloat = 12
        static let imageHeight: CGFloat = 250
        static let descriptionHeight: CGFloat = 200
        
        static let titleFontSize: CGFloat = 24
        static let descriptionFontSize: CGFloat = 16
        
        static let textViewInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}
