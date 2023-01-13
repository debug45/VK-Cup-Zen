//
//  InteractiveFormatViewController.TableViewInterlayer.swift
//  Zen
//
//  Created by Sergey Moskvin on 13.01.2023.
//

import UIKit

final class InteractiveFormatViewControllerTableViewInterlayer: NSObject {
    
    private let getNumberOfItems: () -> Int
    private let getItemCell: (IndexPath) -> UITableViewCell
    private let handleItemCellAppearance: (IndexPath) -> Void
    
    init(getNumberOfItems: @escaping () -> Int, getItemCell: @escaping (IndexPath) -> UITableViewCell, handleItemCellAppearance: @escaping (IndexPath) -> Void) {
        self.getNumberOfItems = getNumberOfItems
        self.getItemCell = getItemCell
        self.handleItemCellAppearance = handleItemCellAppearance
    }
    
}

extension InteractiveFormatViewController {
    typealias TableViewInterlayer = InteractiveFormatViewControllerTableViewInterlayer
}

extension InteractiveFormatViewController.TableViewInterlayer: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getItemCell(indexPath)
    }
    
}

extension InteractiveFormatViewController.TableViewInterlayer: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.handleItemCellAppearance(indexPath)
        }
    }
    
}
