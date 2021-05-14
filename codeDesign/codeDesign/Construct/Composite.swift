//
//  Composite.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/4/28.
//

import Foundation

protocol Component {
    func move(point: CGPoint);
    func draw();
    func id() -> String;
}

extension Component {
    func move(point: CGPoint){
        
    }
    
    func draw(){
        
    }
}

class ComponentId: Component {
    
    private let i: String
    
    init() {
        self.i = "\(Date().timeIntervalSince1970)"
    }
    
    func id() -> String {
        return self.i
    }
}

class Point:  ComponentId {
    
    var p: CGPoint = CGPoint(x: 0, y: 0)
    
    func move(point: CGPoint) {
        self.p = point
    }
    
    func draw() {
        print("p = \(self.p), draw Point")
    }

}

class Circle: ComponentId {
    var p: CGPoint = CGPoint(x: 0, y: 0)
    
    func move(point: CGPoint) {
        self.p = point
    }
    
    func draw() {
        print("p = \(self.p), draw Circle")
    }
}

class Composite: ComponentId {
    
    var children: [Component] = [Component]()
    
    func draw() {
        for child in self.children {
            child.draw()
        }
    }
    
    func move(point: CGPoint) {
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
