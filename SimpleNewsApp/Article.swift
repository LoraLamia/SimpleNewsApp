//
//  Article.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}
