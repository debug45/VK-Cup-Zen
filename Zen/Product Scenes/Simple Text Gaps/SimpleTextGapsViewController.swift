//
//  SimpleTextGapsViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 16.01.2023.
//

import UIKit

final class SimpleTextGapsViewController: InteractiveFormatViewController<
    SimpleTextGapsViewControllerSimpleTextGapsCell.Model,
    SimpleTextGapsViewControllerSimpleTextGapsCell
> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
    
    override var navigationBarTitle: String {
        return InteractiveFormat.simpleTextGaps.title
    }
    
    override var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return LocalizedStrings.Scene.SimpleTextGaps.guide
    }
    
    override func createItemModelsPortion() -> [SimpleTextGapsCell.Model] {
        return FakeData.simpleTextGapsModels.map {
            return .init(
                template: $0.template,
                inserts: $0.inserts.map { .init(title: $0) }
            )
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        reloadTableView()
    }
    
}
