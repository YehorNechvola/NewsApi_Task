//
//  ArticleTableViewCell.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit
import Kingfisher

final class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let id = String(describing: ArticleTableViewCell.self)
    private let imagePlaceholder: UIImage? = UIImage(systemName: "photo")?
        .withTintColor(.red, renderingMode: .alwaysOriginal)

    // MARK: - UI
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.descriptionFontSize)
        label.textColor = .secondaryLabel
        label.numberOfLines = Constants.descriptionMaxLines
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = Constants.textStackSpacing
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [articleImageView, textStackView])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = Constants.mainStackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Setup Layout
    private func setupLayout() {
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalPadding),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalPadding),
            
            articleImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            articleImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
    
    // MARK: - Configure
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        if let urlString = article.urlToImage {
            articleImageView.downloadImage(url: urlString, placeholder: imagePlaceholder)
        } else {
            articleImageView.image = imagePlaceholder
        }
    }
}

// MARK: - Constants
extension ArticleTableViewCell {
    enum Constants {
        static let horizontalPadding: CGFloat = 12
        static let verticalPadding: CGFloat = 8
        
        static let mainStackSpacing: CGFloat = 12
        static let textStackSpacing: CGFloat = 4
        
        static let imageCornerRadius: CGFloat = 8
        static let imageWidth: CGFloat = 130
        static let imageHeight: CGFloat = 90
        
        static let titleFontSize: CGFloat = 14
        static let descriptionFontSize: CGFloat = 14
        static let descriptionMaxLines = 2
    }
}
