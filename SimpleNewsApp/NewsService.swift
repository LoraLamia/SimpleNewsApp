//
//  NewsManager.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import Alamofire
import Foundation

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

