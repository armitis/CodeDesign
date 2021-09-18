//
//  Memento.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/9/14.
//

import Foundation
import UIKit

class TextEditor {
    
    var text: String?
    var point: CGPoint?
    var height: CGFloat = 0
    
    func save() -> Memento {
        return Memento(txt: self.text ?? "", point: self.point ?? CGPoint.zero, height: self.height)
    }
    
    func resotre(m: Memento) {
        self.text = m.text
        self.point = m.point
        self.height = m.height
    }
}

class Memento {
    
    var text: String?
    var point: CGPoint?
    var height: CGFloat = 0
    
    init(txt: String, point: CGPoint, height: CGFloat) {
        self.text = txt
        self.point = point
        self.height = height
    }
    
}


class Command {
    
    let textEditor: TextEditor
    var history = [Memento]()
    
    init(te: TextEditor) {
        self.textEditor = te
    }
    
    func save() {
        self.history.append(self.textEditor.save())
    }
    
    func revoke() {
        if let m = self.history.last {
            self.textEditor.resotre(m: m)
            self.history.removeLast()
        }
    }
}

func testMemento() {
    
    let te = TextEditor()
    let c = Command(te: te)
    c.save()
    
    c.save()
    te.text = "123"
    print("\(te.text!)")
    
    c.save()
    te.text = "123456"
    print("\(te.text!)")
    
    c.save()
    te.text = "123456789"
    print("\(te.text!)")
    
    c.revoke()
    print("\(te.text!)")
    
    c.revoke()
    print("\(te.text!)")
    
    c.revoke()
    print("\(te.text!)")
}
