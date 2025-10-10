//
//  DetailsViewModel.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import Foundation

protocol DetailsViewModelProtocol {
    var article: Article { get }
    func atachOutput(_ output: DetailsViewModel.Output)
    func onLoad()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Output
    struct Output {
        var onLoad: () -> Void
    }
    
    // MARK: - Properties
    var output: Output!
    let article: Article
    
    // MARK: - Init
    init(article: Article) {
        self.article = article
    }
    
    // MARK: - Prorocol Properties
    func atachOutput(_ output: Output) {
        self.output = output
    }
    
    func onLoad() {
        output.onLoad()
    }
}
