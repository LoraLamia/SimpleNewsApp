//
//  NewsTableViewCell.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import UIKit
import PureLayout
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var authorLabel = UILabel()
    private let dateLabel = UILabel()
    private var articleImageView = UIImageView()
    
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
        articleImageView.kf.cancelDownloadTask()
        titleLabel.text = ""
        descriptionLabel.text = ""
        authorLabel.text = ""
        dateLabel.text = ""
        articleImageView.image = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(articleImageView)
    }
    
    private func setupConstraints() {
        let margin: CGFloat = 12
        let spacing: CGFloat = 6

        articleImageView.autoSetDimension(.width, toSize: 80)
        articleImageView.autoSetDimension(.height, toSize: 80)
        articleImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        articleImageView.autoAlignAxis(toSuperviewAxis: .horizontal)

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: margin)
        titleLabel.autoPinEdge(.leading, to: .trailing, of: articleImageView, withOffset: spacing)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)

        authorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: spacing)
        authorLabel.autoPinEdge(.leading, to: .trailing, of: articleImageView, withOffset: spacing)

        dateLabel.autoAlignAxis(.horizontal, toSameAxisOf: authorLabel)
        dateLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: authorLabel, withOffset: spacing)
        descriptionLabel.autoPinEdge(.leading, to: .trailing, of: articleImageView, withOffset: spacing)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: margin)
    }


    
    
    private func styleViews() {
        contentView.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.95, alpha: 0.8)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1)
        titleLabel.numberOfLines = 1
        
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.7)
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.7)
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.numberOfLines = 2
        
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 8
        
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
    }
    
    func configure(article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.author
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US_POSIX")
        dateLabel.text = formatter.string(from: article.publishedAt)
        
        if let url = URL(string: article.urlToImage) {
            articleImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            articleImageView.image = UIImage(systemName: "photo")
        }
    }
    
}
