//
//  SimpleFactory.swift
//  Design-Patterns
//
//  Created by 郑智文 on 2018/12/13.
//  Copyright © 2018 郑智文. All rights reserved.
//

import Foundation

enum SimpleFactorySpace {
    class SimpleFactory {
        func product<T: Functional>(_ classType: T.Type, _ data: String) -> T {
            return classType.init(data: data)
        }
    }
    
    static func run() {
        let factory = SimpleFactory()
        factory.product(ProductA.self, "A-product1").use()
        factory.product(ProductB.self, "B-product1").use()
        factory.product(ProductB.self, "B-product2").use()
    }
}
