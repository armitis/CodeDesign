//
//  Single.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2021/11/18.
//

import Foundation
import UIKit


class Single {
    
    let name: String
    let id: Int
    
    static let instance = Single()
    
    private init() {
        self.name = "123"
        self.id = 123
    }
    
}

func testSingle() {
    
    //编译不过
//    let s = Single.instance

    let s = Single.instance
    print("\(s.name), \(s.id)")
}
