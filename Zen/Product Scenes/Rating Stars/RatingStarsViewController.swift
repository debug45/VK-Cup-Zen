//
//  RatingStarsViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

final class RatingStarsViewController: UIViewController {
    
    private let guideLabel = UILabel {
        $0.alpha = 0.5
        $0.numberOfLines = 0
        $0.text = LocalizedStrings.Scene.RatingStars.guide
        $0.textAlignment = .center
    }
    
    private lazy var tableView = UITableView {
        $0.allowsSelection = false
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
            guideLabel,
            tableView
        )
        
        let defaultInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            guideLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: defaultInset),
            guideLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -defaultInset),
            
            guideLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 16),
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
            
            cell.ratingChangeHandler = { [weak self] newValue in
                self?.dataModels[indexPath.row].score = newValue
            }
            
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
