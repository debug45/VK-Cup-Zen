//
//  InteractiveFormatViewController.ItemCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 13.01.2023.
//

import UIKit

protocol InteractiveFormatViewControllerItemCell<Model>: UITableViewCell {
    
    associatedtype Model
    func configure(with model: Model)
    
}

extension InteractiveFormatViewController {
    typealias ItemCell = InteractiveFormatViewControllerItemCell
}
