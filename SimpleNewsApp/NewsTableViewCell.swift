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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
//        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
//        titleLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 8)
//        titleLabel.autoPinEdge(toSuperviewMargin: .leading, withInset: 8)
        titleLabel.autoCenterInSuperview()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }

}
