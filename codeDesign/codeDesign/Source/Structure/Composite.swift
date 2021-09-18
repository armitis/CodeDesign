//
//  Composite.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/4/28.
//

import Foundation
import UIKit

protocol Component {
    func move(point: CGPoint);
    func draw();
    func id() -> String;
}

class ComponentId: Component {
    
    private let i: String
    
    init() {
        self.i = "\(Date().timeIntervalSince1970)"
    }
    
    func id() -> String {
        return self.i
    }
    
    func move(point: CGPoint){
        
    }
    
    func draw(){
        
    }
}

class Point:  ComponentId {
    
    var p: CGPoint = CGPoint(x: 0, y: 0)
    
    override func move(point: CGPoint) {
        self.p = point
    }
    
    override func draw() {
        print("p = \(self.p), draw Point")
    }

}

class Circle: ComponentId {
    var p: CGPoint = CGPoint(x: 0, y: 0)
    
    override func move(point: CGPoint) {
        self.p = point
    }
    
    override func draw() {
        print("p = \(self.p), draw Circle")
    }
}

class Composite: ComponentId {
    
    var children: [Component] = [Component]()
    
    override func draw() {
        for child in self.children {
            child.draw()
        }
    }
    
    override func move(point: CGPoint) {
        for child in self.children {
            child.move(point: point)
        }
    }
    
    func addChild(c: Component) {
        self.children.append(c)
    }
    
    func removeChild(c: Component) {
        if let index = self.children.firstIndex(where: { (c2) -> Bool in
            return c.id() == c2.id()
        }) {
            self.children.remove(at: index)
        }
    }
}

func compositeTest() {
    
    let p = Point()
    let circle = Circle()
    
    let c = Composite()
    c.addChild(c: p)
    c.move(point: CGPoint(x: 100, y: 100))
    c.draw()
    
    c.addChild(c: circle)
    c.move(point: CGPoint(x: 200, y: 200))
    c.draw()
    
    c.removeChild(c: p)
    c.move(point: CGPoint(x: 150, y: 150))
    c.draw()
}
