//
//  EditableTextGapsCell.TextField.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension EditableTextGapsViewController.EditableTextGapsCell {
    final class TextField: UITextField {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            delegate = self
            
            layer.borderColor = UIColor.Zen.foreground.cgColor
            layer.borderWidth = 1.5
            
            layer.cornerRadius = 12
            
            autocapitalizationType = .none
            autocorrectionType = .no
            
            textAlignment = .center
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var maxTextLength: Int?
        
        var returnKeyPressHandler: (() -> Void)?
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let horizontal: CGFloat = 8
            
            return bounds.inset(
                by: .init(top: 0, left: horizontal, bottom: 0, right: horizontal)
            )
        }
        
    }
}

extension EditableTextGapsViewController.EditableTextGapsCell.TextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let maxTextLength else {
            return true
        }
        
        return (textField.text?.count ?? 0) - range.length + string.count <= maxTextLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnKeyPressHandler?()
        return true
    }
    
}
