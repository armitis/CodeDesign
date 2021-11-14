//
//  Clone.swift
//  CodeDesign
//
//  Created by 郑智文 on 2021/11/14.
//

import Foundation
import UIKit

class Shape {
    
    let point: CGPoint
    
    init(p: CGPoint) {
        self.point = p
    }
    
    init(shape: Shape) {
        self.point = shape.point
    }
    
    func clone() -> Shape {
        return Shape(shape: self)
    }
}

class CDCircle: Shape {
    
    let radius: Float
    
    init(p: CGPoint, r: Float) {
        self.radius = r
        super.init(p: p)
    }
    
    override init(shape: Shape) {
        guard let c = shape as? CDCircle else {
            self.radius = 0
            super.init(shape: shape)
            return
        }
        self.radius = c.radius
        super.init(shape: shape)
    }
}

class CDRectangle: Shape {
    
    let width: Float
    let height: Float
    
    init(p: CGPoint, w: Float, h: Float) {
        self.width = w
        self.height = h
        super.init(p: p)
    }
    
    override init(shape: Shape) {
        guard let r = shape as? CDRectangle else {
            self.width = 0
            self.height = 0
            super.init(shape: shape)
            return
        }
        self.width = r.width
        self.height = r.height
        super.init(shape: shape)
    }
}

func testClone() {
    let shape = Shape(p: CGPoint(x: 20, y: 10))
    let circle = CDCircle(p: CGPoint(x: 100, y: 100), r: 24)
    let rectangle = CDRectangle(p: CGPoint(x: 30, y: 30), w: 22, h: 33)
    
    print("shape: \(shape), circle: \(circle), rectangle: \(rectangle)")
    
    let shape2 = shape.clone()
    let circle2 = circle.clone()
    let rectangle2 = rectangle.clone()
    
    print("shape2: \(shape2), cirlce2: \(circle2), rectangle2: \(rectangle2)")
}
