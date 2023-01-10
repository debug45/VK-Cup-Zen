//
//  RatingStarsViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

final class RatingStarsViewController: UIViewController {
    
    private lazy var tableView = UITableView {
        $0.dataSource = self
        $0.delegate = self
    }
    
    private let cellType = RatingStarsCell.self
    private var dataModels: [RatingStarsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = InteractiveFormat.ratingStars.title
        view.backgroundColor = .Zen.background
        
        view.addSubviews(
            tableView
        )
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appendDataPortion()
    }
    
    private func appendDataPortion() {
        dataModels.append(contentsOf: FakeData.ratingStarsModels)
        tableView.reloadData()
    }
    
}

extension RatingStarsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var configured: UITableViewCell?
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? RatingStarsCell {
            let model = dataModels[indexPath.row]
            cell.configure(from: model)
            
            configured = cell
        }
        
        return configured ?? .init()
    }
    
}

extension RatingStarsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == dataModels.count - 1 else {
            return
        }
        
        appendDataPortion()
    }
    
}
