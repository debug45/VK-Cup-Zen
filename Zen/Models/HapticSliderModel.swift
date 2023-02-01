//
//  HapticSliderModel.swift
//  Zen
//
//  Created by Sergey Moskvin on 01.02.2023.
//

struct HapticSliderModel {
    
    let title: String
    
    let minExample: Benchmark
    let maxExample: Benchmark
    
    let target: Benchmark
    
    struct Benchmark {
        
        let title: String
        let value: Float
        
    }
    
}
