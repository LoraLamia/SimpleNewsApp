//
//  SimpleNewsAppTests.swift
//  SimpleNewsAppTests
//
//  Created by Lora Zubic on 02.09.2025..
//

import XCTest
@testable import SimpleNewsApp

class ArticleParsingTests: XCTestCase {

    func testArticleDecoding() throws {

        let json = """
        {
            "author": "John Doe",
            "title": "Sample News Title",
            "description": "This is a sample description",
            "url": "https://example.com/news",
            "urlToImage": "https://example.com/image.jpg",
            "publishedAt": "2025-09-02T10:15:30Z",
            "content": "Full content of the article"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let article = try decoder.decode(Article.self, from: json)
            XCTAssertEqual(article.author, "John Doe")
            XCTAssertEqual(article.title, "Sample News Title")
            XCTAssertEqual(article.description, "This is a sample description")
            XCTAssertEqual(article.url, "https://example.com/news")
            XCTAssertEqual(article.urlToImage, "https://example.com/image.jpg")
            XCTAssertEqual(article.content, "Full content of the article")

            let formatter = ISO8601DateFormatter()
            let expectedDate = formatter.date(from: "2025-09-02T10:15:30Z")
            XCTAssertEqual(article.publishedAt, expectedDate)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
