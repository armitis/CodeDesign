//
//  Product.swift
//  Design-Patterns
//
//  Created by 郑智文 on 2018/12/13.
//  Copyright © 2018 郑智文. All rights reserved.
//

import Foundation

protocol Functional {
    func use() -> Void
    init(data: String)
}

extension SimpleFactorySpace{
    
    class ProductA: Functional {
        var name: String
        
        required init(data: String) {
            name = data
        }
        
        
        func use() {
            print("A name = \(name)")
        }
    }
    
    class ProductB: Functional {
        var name : String
        
        required init(data: String) {
            name = data
        }
        
        func use() {
            print("B name= \(name)")
        }
    }
}

