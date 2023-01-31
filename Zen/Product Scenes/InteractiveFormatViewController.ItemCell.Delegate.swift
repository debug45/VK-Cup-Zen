//
//  InteractiveFormatViewController.ItemCell.Delegate.swift
//  Zen
//
//  Created by Sergey Moskvin on 31.01.2023.
//

import UIKit

protocol InteractiveFormatViewControllerItemCellDelegate: AnyObject {
    func presentAlertController(_ alertController: UIAlertController)
}

extension InteractiveFormatViewController.ItemCell {
    typealias Delegate = InteractiveFormatViewControllerItemCellDelegate
}
