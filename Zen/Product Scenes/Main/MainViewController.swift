//
//  MainViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let cellType = InteractiveFormatCell.self
    
    private lazy var tableView = UITableView {
        $0.dataSource = self
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LocalizedStrings.Scene.Main.title
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
            
            switch model {
                case .stepwisePoll, .elementsMatching, .ratingStars:
                    cell.contentView.alpha = 1
                    cell.selectionStyle = .default
                    
                case .simpleTextGaps, .editableTextGaps:
                    cell.contentView.alpha = 0.5
                    cell.selectionStyle = .none
            }
            
            configured = cell
        }
        
        return configured ?? .init()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var target: UIViewController?
        
        switch InteractiveFormat.allCases[indexPath.row] {
            case .stepwisePoll:
                target = StepwisePollViewController()
            case .elementsMatching:
                target = ElementsMatchingViewController()
            case .simpleTextGaps:
                break
            case .editableTextGaps:
                break
            case .ratingStars:
                target = RatingStarsViewController()
        }
        
        if let target {
            Instances.shared.rootNavigationController.pushViewController(target, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return FooterView()
    }
    
}
