//
//  Flyweight.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/5/28.
//

import Foundation
import SwiftUI

class TreeType {
    let textTure: String
    let name: String
    let color: Color
    let id: String
    
    init(_ t: String, _ n: String, _ c: Color) {
        self.textTure = t
        self.name = n
        self.color = c
        self.id = "\((Int)(Date().timeIntervalSince1970 * 100000))"
    }
    
    func draw(canvas: Canvas, point: CGPoint) {
        print("在\(canvas.name) 画了一棵树, id: \(self.id), 位置: \(point), 纹理是: \(self.textTure), 颜色是: \(self.color), 名称是: \(self.name)")
    }
}

class Canvas {
    let name: String
    
    init(_ n: String) {
        self.name = n
    }
}

class TreeTypeFactory {
    
    var types:[TreeType] = [TreeType]()
    
    func typeBy(name: String, color: Color, textTure: String) -> TreeType {
        if let first = self.types.first(where: {
            if $0.name == name, $0.color == color, $0.textTure == textTure {
                return true
            }
            return false
        }) {
            return first
        }
        let t = TreeType(textTure, name, color)
        self.types.append(t)
        return t
    }
}

class Tree {
    
    let tt: TreeType
    let point: CGPoint
    
    init(_ type: TreeType, _ p: CGPoint) {
        self.tt = type
        self.point = p
    }
    
    func draw(_ canvas: Canvas) {
        self.tt.draw(canvas: canvas, point: self.point)
    }
}

class Forest {
    
    var trees:[Tree] = [Tree]()
    
    func plantTree(_ tree: Tree) {
        self.trees.append(tree)
    }
    
    func draw(_ canvas: Canvas) {
        for t in self.trees {
            t.draw(canvas)
        }
    }
}

func testFlyweight() {
    
    let typeFactory = TreeTypeFactory()
    let c = Canvas("画布1")
    
    let treeType = typeFactory.typeBy(name: "杉树", color: Color.red, textTure: "格子")
    let treeType2 = typeFactory.typeBy(name: "杨树", color: Color.white, textTure: "竖条")
    
    let tree1 = Tree(treeType, CGPoint(x: 100, y: 100))
    let tree2 = Tree(treeType, CGPoint(x: 200, y: 100))
    let tree3 = Tree(treeType, CGPoint(x: 300, y: 100))
    let tree4 = Tree(treeType, CGPoint(x: 400, y: 100))
    let tree5 = Tree(treeType2, CGPoint(x: 500, y: 100))
    
    let f = Forest()
    f.plantTree(tree1)
    f.plantTree(tree2)
    f.plantTree(tree3)
    f.plantTree(tree4)
    f.plantTree(tree5)
    
    f.draw(c)
}
