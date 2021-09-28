//
//  Visitor.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2021/9/28.
//

import Foundation
import UIKit

class Node {
    
    let point: CGPoint
    
    var next: Node?
    
    init(p: CGPoint) {
        self.point = p
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(node: self)
    }
}

class DotNode: Node {
    
    override init(p: CGPoint) {
        super.init(p: p)
    }
    
    override func accept(visitor: Visitor) {
        visitor.visitDot(dot: self)
    }
}

class CircleNode: Node {
    
    let radius: Float
    
    init(p: CGPoint, r: Float) {
        self.radius = r
        super.init(p: p)
    }
    
    override func accept(visitor: Visitor) {
        visitor.visitCircle(circle: self)
    }
}

class RectangleNode: Node {
    
    let width: Float
    let height: Float
    
    init(p: CGPoint, w: Float, h: Float) {
        self.height = h
        self.width = w
        super.init(p: p)
    }
    
    override func accept(visitor: Visitor) {
        visitor.visitRectangle(rectangle: self)
    }
  
}


class Visitor {
    
    func visit(node: Node) {
        print("这是一个原始基类: 坐标: \(node.point)")
    }
    
    func visitDot(dot: DotNode) {
        print("这是一个点: 坐标: \(dot.point)")
    }

    func visitCircle(circle: CircleNode) {
        print("这是一个圆: 圆心: \(circle.point), 半径: \(circle.radius)")
    }

    func visitRectangle(rectangle: RectangleNode) {
        print("这是一个矩形: 左上顶点: \(rectangle.point), 宽: \(rectangle.width), 高: \(rectangle.height)")
    }
}

func testVisitor() {
    
    let dot = DotNode(p: CGPoint(x: 100, y: 100))
    let circle = CircleNode(p: CGPoint(x: 200, y: 150), r: 50)
    let rectangle = RectangleNode(p: CGPoint(x: 250, y: 140), w: 60, h: 30)
    
    let visitor = Visitor()
    
    dot.next = circle
    circle.next = rectangle
    var current: Node? = nil
    current = dot
    
    while current != nil {
        guard let c = current else {
            return
        }
        c.accept(visitor: visitor)
        current = c.next
    }
}

