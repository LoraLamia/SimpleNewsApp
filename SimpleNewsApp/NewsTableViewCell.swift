//
//  NewsTableViewCell.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import UIKit
import PureLayout

class NewsTableViewCell: UITableViewCell {
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var authorLabel = UILabel()
    private var urlLabel = UILabel()
    private let publishedAtLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        styleViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        authorLabel.text = ""
        publishedAtLabel.text = ""
        urlLabel.text = ""
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(publishedAtLabel)
        contentView.addSubview(urlLabel)
    }
    
    private func setupConstraints() {
        let margin: CGFloat = 16
        let spacing: CGFloat = 6
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        authorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: spacing)
        authorLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        
        publishedAtLabel.autoAlignAxis(.horizontal, toSameAxisOf: authorLabel)
        publishedAtLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: authorLabel, withOffset: spacing)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        
        urlLabel.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: spacing)
        urlLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        urlLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        urlLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
    }
    
    private func styleViews() {
        contentView.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.95, alpha: 0.8)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1)
        titleLabel.numberOfLines = 0
        
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.7)
        
        publishedAtLabel.font = .systemFont(ofSize: 12)
        publishedAtLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.7)
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.numberOfLines = 0
        
        urlLabel.font = .systemFont(ofSize: 12)
        urlLabel.textColor = UIColor.darkGray
        urlLabel.numberOfLines = 0
    }
    
    func configure(article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.author
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US_POSIX")
        publishedAtLabel.text = formatter.string(from: article.publishedAt)
        
        urlLabel.text = "Resource: \(article.url)"
    }
    
}
