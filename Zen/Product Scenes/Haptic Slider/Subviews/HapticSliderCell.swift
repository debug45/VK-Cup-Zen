//
//  HapticSliderCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 01.02.2023.
//

import UIKit

final class HapticSliderViewControllerHapticSliderCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
}

extension HapticSliderViewController {
    typealias HapticSliderCell = HapticSliderViewControllerHapticSliderCell
}

extension HapticSliderViewController.HapticSliderCell {
    final class Model {
        
        let title: String
        
        let minExample: Benchmark
        let maxExample: Benchmark
        
        let target: Benchmark
        
        init(title: String, minExample: Benchmark, maxExample: Benchmark, target: Benchmark) {
            self.title = title
            
            self.minExample = minExample
            self.maxExample = maxExample
            
            self.target = target
        }
        
        struct Benchmark {
            
            let title: String
            let value: Float
            
        }
        
    }
}
