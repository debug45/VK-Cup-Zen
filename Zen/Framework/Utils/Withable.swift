//
//  Withable.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

protocol Withable {
    init()
}

extension Withable {
    
    init(with configuration: (Self) -> Void) {
        self.init()
        configuration(self)
    }
    
    func with(_ configuration: (Self) -> Void) -> Self {
        configuration(self)
        return self
    }
    
}
