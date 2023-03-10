//
//  InteractiveFormatViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 13.01.2023.
//

import UIKit

class InteractiveFormatViewController<
    ItemModel,
    ItemCell: InteractiveFormatViewControllerItemCell<ItemModel>
>: UIViewController {
    
    private var availableWidth: CGFloat?
    private var itemModels: [ItemModel] = []
    
    let rightBarLabel = UILabel {
        $0.textAlignment = .right
        $0.textColor = .Zen.foreground
    }
    
    private lazy var guideLabel = UILabel {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = .Zen.foreground
    }
    
    private lazy var tableView = UITableView {
        $0.allowsSelection = false
        $0.dataSource = tableViewInterlayer
        $0.delegate = tableViewInterlayer
    }
    
    private lazy var tableViewInterlayer = TableViewInterlayer(
        getNumberOfItems: { [weak self] in
            self?.getNumberOfItems() ?? 0
        },
        getItemCell: { [weak self] in
            self?.getItemCell(for: $0) ?? .init()
        },
        
        handleItemCellAppearance: { [weak self] in
            self?.handleItemCellAppearance(indexPath: $0)
        },
        handleSomeScroll: { [weak self] in
            self?.handleSomeScroll()
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navigationBarTitle
        
        navigationItem.setRightBarButton(
            .init(customView: rightBarLabel),
            animated: false
        )
        
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
        
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        configureGuideLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rightBarLabel.frame.size.width = 0
        
        updateAvailableWidth()
        appendItemModels()
    }
    
    var navigationBarTitle: String {
        return ""
    }
    
    var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return ("", [])
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateAvailableWidth()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { _ in
            self.updateAvailableWidth()
        }
    }
    
    func createItemModelsPortion() -> [ItemModel] {
        return []
    }
    
    func getVisibleCells() -> [UITableViewCell] {
        return tableView.visibleCells
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func handleSomeScroll() { }
    
    private func appendItemModels() {
        itemModels.append(
            contentsOf: createItemModelsPortion()
        )
        
        tableView.reloadData()
    }
    
    private func getNumberOfItems() -> Int {
        return itemModels.count
    }
    
    private func getItemCell(for indexPath: IndexPath) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell else {
            return nil
        }
        
        cell.availableWidth = availableWidth
        cell.delegate = self
        
        cell.model = itemModels[indexPath.row]
        return cell
    }
    
    private func handleItemCellAppearance(indexPath: IndexPath) {
        guard indexPath.row == itemModels.count - 1 else {
            return
        }
        
        appendItemModels()
    }
    
    private func configureGuideLabel() {
        let data = correspondingFormatGuide
        
        let fontSize: CGFloat = 17
        let textColor = UIColor.Zen.foreground
        
        let attributedString = NSMutableAttributedString(string: data.string, attributes: [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: textColor.withAlphaComponent(0.5)
        ])
        
        data.boldRanges.forEach {
            attributedString.addAttributes([
                .font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
                .foregroundColor: textColor
            ], range: $0)
        }
        
        guideLabel.attributedText = attributedString
    }
    
    private func updateAvailableWidth() {
        let safeAreaInsets = view.safeAreaInsets
        availableWidth = view.bounds.width - safeAreaInsets.left - safeAreaInsets.right
    }
    
}

extension InteractiveFormatViewController: InteractiveFormatViewControllerItemCellDelegate {
    
    func updateRightBarLabel(text: String) {
        rightBarLabel.text = text
    }
    
    func presentAlertController(_ alertController: UIAlertController) {
        present(alertController, animated: true)
    }
    
}
