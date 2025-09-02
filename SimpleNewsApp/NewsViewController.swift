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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        addSubviews()
        setupTableView()
        editViews()
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
    
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = mockData[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: new)
        return cell
    }
}

