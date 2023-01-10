//
//  MainViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let cellType = InteractiveFormatCell.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LocalizedStrings.Scene.Main.title
        
        view.backgroundColor = .Zen.background
        
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InteractiveFormat.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var configured: UITableViewCell?
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? InteractiveFormatCell {
            let model = InteractiveFormat.allCases[indexPath.row]
            
            let title = "\(model.icon) \(model.title)"
            cell.configure(title: title)
            
            configured = cell
        }
        
        return configured ?? .init()
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch InteractiveFormat.allCases[indexPath.row] {
            case .stepwisePoll:
                break
            case .elementMatching:
                break
            case .simpleTextGaps:
                break
            case .editableTextGaps:
                break
            case .ratingStars:
                break
        }
    }
}
