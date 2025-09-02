//
//  ViewController.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import UIKit
import PureLayout
import Kingfisher

class NewsViewController: UIViewController {
    private let newsTableView = UITableView()
    private let service = NewsService()
    private var news: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        fetchNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsTableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(newsTableView)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        newsTableView.autoPinEdgesToSuperviewSafeArea()
    }
    
    private func fetchNews() {
        service.fetchNews(page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.news = news
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ups, something went wrong!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = news[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = news[indexPath.row]
        let articleDetailsViewController = ArticleDetailsViewController(article: article)
        navigationController?.pushViewController(articleDetailsViewController, animated: true)
    }
    
}

