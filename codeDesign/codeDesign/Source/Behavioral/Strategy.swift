//
//  Strategy.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2021/9/29.
//

import Foundation

enum CaculateType {
    case add, subtraction, multiplication
}

protocol Caculator {
    
    func excute(a: Int, b: Int) -> Int
}

class AddCaculator: Caculator {
    
    func excute(a: Int, b: Int) -> Int {
        return a + b
    }
}

class SubtractionCaculator: Caculator {
    
    func excute(a: Int, b: Int) -> Int {
        return a - b
    }
}

class MultipleCaculator: Caculator {
    
    func excute(a: Int, b: Int) -> Int {
        return a * b
    }
}

class CaculatorManager {
    
    var cacualtor: Caculator?
    
    init() {
        self.cacualtor = AddCaculator()
    }
    
    var type: CaculateType = .add {
        didSet {
            switch self.type {
            case .add:
                self.cacualtor = AddCaculator()
            case .subtraction:
                self.cacualtor = SubtractionCaculator()
            case .multiplication:
                self.cacualtor = MultipleCaculator()
            }
        }
    }
    
    func excute(a: Int, b: Int) -> Int {
        guard let c = self.cacualtor else {
            return 0
        }
        return c.excute(a: a, b: b)
    }
}

func testStrategy() {
    
    let manager = CaculatorManager()
    let a = 100
    let b = 20
    
    print("\(manager.excute(a: a, b: b))")
    
    manager.type = .subtraction
    print("\(manager.excute(a: a, b: b))")
    
    manager.type = .multiplication
    print("\(manager.excute(a: a, b: b))")
}
