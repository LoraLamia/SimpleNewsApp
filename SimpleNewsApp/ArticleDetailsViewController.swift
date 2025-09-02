//
//  ArticleDetailsViewController.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import UIKit
import PureLayout

class ArticleDetailsViewController: UIViewController {
    
    private var article: Article
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let contentLabel = UILabel()
    private let urlLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        styleViews()
        configure()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.autoMatch(.width, to: .width, of: scrollView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(urlLabel)
        contentView.addSubview(contentLabel)
    }
    
    private func setupConstraints() {
        scrollView.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdgesToSuperviewEdges()
        
        let margin: CGFloat = 16
        let spacing: CGFloat = 12
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: margin)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        authorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: spacing)
        authorLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        
        dateLabel.autoAlignAxis(.horizontal, toSameAxisOf: authorLabel)
        dateLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: authorLabel, withOffset: spacing)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        contentLabel.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: spacing)
        contentLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        contentLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        urlLabel.autoPinEdge(.top, to: .bottom, of: contentLabel, withOffset: spacing)
        urlLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        urlLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        urlLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: margin)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1)
        titleLabel.numberOfLines = 0
        
        authorLabel.font = .systemFont(ofSize: 16)
        authorLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.7)
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.7)
        
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 0
        
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = .darkGray
        contentLabel.numberOfLines = 0
        
        urlLabel.font = .systemFont(ofSize: 16)
        urlLabel.textColor = .darkGray
        urlLabel.numberOfLines = 0
    }
    
    private func configure() {
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.publishedAt.formatted()
        descriptionLabel.text = article.description
        contentLabel.text = article.content.simpleHTMLCleaned
        urlLabel.text = article.url
    }
    
}

extension String {
    var simpleHTMLCleaned: String {
        let withoutTags = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let cleaned = withoutTags.replacingOccurrences(of: "\\n\\s*\\n", with: "\n", options: .regularExpression, range: nil)
        return cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


