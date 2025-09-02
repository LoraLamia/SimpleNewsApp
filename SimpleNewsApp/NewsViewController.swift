//
//  ViewController.swift
//  SimpleNewsApp
//
//  Created by Lora Zubic on 02.09.2025..
//

import UIKit
import PureLayout

class NewsViewController: UIViewController {
    private let newsTableView = UITableView()
    private let mockData = ["news1", "news2", "news3", "news4", "news5", "news6", "news7", "news8", "news9", "news10"]
    private let service = NewsService()
    private var news: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        addSubviews()
        setupTableView()
        editViews()
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
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        
        newsTableView.autoPinEdgesToSuperviewMargins()
    }
    
    private func addSubviews() {
        
    }
    
    private func editViews() {
        
    }
    
    private func fetchNews() {
        service.fetchNews(page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.news = articles
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(article: new)
        return cell
    }
}

