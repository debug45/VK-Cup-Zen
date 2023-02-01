//
//  MainViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let cellType = InteractiveFormatCell.self
    
    private let interactiveFormats: [[InteractiveFormat]] = [
        [.elementsMixing],
        [.stepwisePoll, .elementsMatching, .simpleTextGaps, .editableTextGaps, .ratingStars]
    ]
    
    private lazy var tableView = UITableView {
        $0.contentInset = .init(top: 0, left: 0, bottom: 36, right: 0)
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactiveFormats.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < interactiveFormats.count else {
            return 1
        }
        
        return interactiveFormats[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var configured: UITableViewCell?
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? InteractiveFormatCell {
            if indexPath.section < interactiveFormats.count {
                let model = interactiveFormats[indexPath.section][indexPath.row]
                
                cell.configure(
                    title: "\(model.icon) \(model.title)"
                )
            } else {
                cell.configure(title: LocalizedStrings.Scene.Main.AboutDeveloper.content)
            }
            
            configured = cell
        }
        
        return configured ?? .init()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section < interactiveFormats.count else {
            UIApplication.shared.open(
                .init(string: "https://vk.com/id19187792")!
            )
            
            return
        }
        
        var target: UIViewController?
        
        switch interactiveFormats[indexPath.section][indexPath.row] {
            case .elementsMixing:
                target = ElementsMixingViewController()
                
            case .stepwisePoll:
                target = StepwisePollViewController()
            case .elementsMatching:
                target = ElementsMatchingViewController()
            case .simpleTextGaps:
                target = SimpleTextGapsViewController()
            case .editableTextGaps:
                target = EditableTextGapsViewController()
            case .ratingStars:
                target = RatingStarsViewController()
        }
        
        if let target {
            Instances.rootNavigationController.pushViewController(target, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return LocalizedStrings.Scene.Main.Subtitle.currentStage
            case 1:
                return LocalizedStrings.Scene.Main.Subtitle.previousStage
                
            case 2:
                return LocalizedStrings.Scene.Main.AboutDeveloper.title
                
            default:
                return nil
        }
    }
    
}
