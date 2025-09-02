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
    private let refreshControl = UIRefreshControl()
    
    private var isFetching = false
    private var currentPage = 1
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
    
    @objc private func refreshArticles() {
        currentPage = 1
        news.removeAll()
        newsTableView.reloadData()
        fetchNews()
    }
    
    private func setupTableView() {
        view.addSubview(newsTableView)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        
        newsTableView.autoPinEdgesToSuperviewSafeArea()
    }
    
    private func fetchNews() {
        guard !isFetching else { return }
        isFetching = true
        
        service.fetchNews(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            self.isFetching = false
            switch result {
            case .success(let news):
                handleSuccesCase(news: news)
            case .failure(let error):
                handleErrorCase(message: error.localizedDescription)
            }
        }
    }
    
    private func handleSuccesCase(news: [Article]) {
        if news.isEmpty {
            return
        }
        
        self.news.append(contentsOf: news)
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
        self.currentPage += 1
    }
    
    private func handleErrorCase(message: String) {
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

//extension NewsViewController {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.frame.size.height
//        
//        if offsetY > contentHeight - height - 100 {
//            fetchNews()
//        }
//    }
//    
//}

