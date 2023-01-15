//
//  EditableTextGapsViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

final class EditableTextGapsViewController: InteractiveFormatViewController<
    EditableTextGapsViewControllerEditableTextGapsCell.Model,
    EditableTextGapsViewControllerEditableTextGapsCell
> {
    
    override var navigationBarTitle: String {
        return InteractiveFormat.editableTextGaps.title
    }
    
    override var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return (LocalizedStrings.Scene.EditableTextGaps.guide, [])
    }
    
    override func createItemModelsPortion() -> [EditableTextGapsCell.Model] {
        return FakeData.editableTextGapsModels.map {
            return .init(template: $0.template, inserts: $0.inserts)
        }
    }
    
}
