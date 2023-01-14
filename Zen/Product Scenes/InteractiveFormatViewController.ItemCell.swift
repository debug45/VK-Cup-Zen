//
//  InteractiveFormatViewController.ItemCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 13.01.2023.
//

import UIKit

protocol InteractiveFormatViewControllerItemCell<Model>: UITableViewCell {
    
    associatedtype Model
    var model: Model? { get set }
    
}

extension InteractiveFormatViewController {
    typealias ItemCell = InteractiveFormatViewControllerItemCell
}
