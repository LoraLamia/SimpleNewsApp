//
//  NewsManager.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import Alamofire
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        author = try container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        url = try container.decode(String.self, forKey: .url)
        urlToImage = try container.decode(String.self, forKey: .urlToImage)
        content = try container.decode(String.self, forKey: .content)

        let dateString = try container.decode(String.self, forKey: .publishedAt)

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]

        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .publishedAt,
                in: container,
                debugDescription: "Date string does not match format expected by formatter.")
        }

        publishedAt = date
    }
}

class NewsService {
    private let APIKey = "3719e0706c6741148118532b71fb86dd"
    
    func fetchNews(page: Int, completion: @escaping (Result<[Article], AFError>) -> Void) {
        let parameters: [String: Any] = [
            "apiKey": APIKey,
            "q": "apple",
            "pageSize": 20,
            "page": page
        ]
        
        AF.request(
            "https://newsapi.org/v2/everything",
            method: .get,
            parameters: parameters
        )
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let newsResponse):
                let news = newsResponse.articles
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
}

