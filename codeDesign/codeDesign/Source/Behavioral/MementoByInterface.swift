//
//  MementoByInterface.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2022/12/30.
//

import Foundation
import UIKit

protocol ISnapshot {
    func restore()
}

enum MementoByInterface {
    
    class TextEditor {
        
        private var text: String?
        private var cursor: CGPoint = CGPointZero
        private var selectionWidth: CGFloat = 0
        
        func setText(txt: String?) {
            self.text = txt
        }
        
        func getText() -> String? {
            return self.text
        }
        
        private func setCursor(cursor: CGPoint) {
            self.cursor = cursor
        }
        
        private func setSelectionWidth(width: CGFloat) {
            self.selectionWidth = width
        }
        
        func createSnapshot() -> ISnapshot {
            return ConcreteSnapshot(edit: self, txt: self.text ?? "", cursor: self.cursor, selectionWidth: self.selectionWidth)
        }
        
        func restore(snap: ISnapshot) {
            guard let sn = snap as? ConcreteSnapshot else {
                return
            }
            self.setText(txt: sn.text)
            self.setCursor(cursor: sn.cursor)
            self.setSelectionWidth(width: sn.selectionWidth)
        }
    }
    
    class ConcreteSnapshot:ISnapshot {
        
        var text: String?
        var cursor: CGPoint
        var selectionWidth: CGFloat = 0
        var edit: TextEditor?
        
        init(edit: TextEditor,txt: String, cursor: CGPoint, selectionWidth: CGFloat) {
            self.text = txt
            self.cursor = cursor
            self.selectionWidth = selectionWidth
            self.edit = edit
        }
        
        func restore() {
            guard let te = self.edit else {
                return
            }
            te.restore(snap: self)
        }
    }
    
    class Command {
        
        private let editor: TextEditor
        private var ss: ISnapshot?
        
        init(edit: TextEditor) {
            self.editor = edit
        }
        
        func makeBackup() {
            self.ss = self.editor.createSnapshot()
        }
        
        func excute() {
            self.editor.setText(txt: "456")
        }
        
        func undo() {
            guard let s = ss else {
                return
            }
            
            s.restore()
        }
    }
}

func testMemento2() {
    
    let te = MementoByInterface.TextEditor()
    te.setText(txt: "1233")
    
    print(te.getText() ?? "")
    
    let c = MementoByInterface.Command(edit: te)
    c.makeBackup()
    c.excute()
    
    print(te.getText() ?? "")
    
    c.undo()
    print(te.getText() ?? "")
    
    
}
