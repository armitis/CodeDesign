//
//  Memento.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/9/14.
//

import Foundation
import UIKit

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
    
    func createSnapshot() -> Snapshot {
        return Snapshot(edit: self, txt: self.text ?? "", cursor: self.cursor, selectionWidth: self.selectionWidth)
    }
    
    class Snapshot {
        
        private var text: String?
        private var cursor: CGPoint
        private var selectionWidth: CGFloat = 0
        private var edit: TextEditor?
        
        init(edit: TextEditor,txt: String, cursor: CGPoint, selectionWidth: CGFloat) {
            self.text = txt
            self.cursor = cursor
            self.selectionWidth = selectionWidth
            self.edit = edit
        }
        
        func restore() {
            guard let e = self.edit else {
                return
            }
            e.setText(txt: self.text)
            e.setCursor(cursor: self.cursor)
            e.setSelectionWidth(width: self.selectionWidth)
        }
    }
}

class Command {
    
    private let editor: TextEditor
    private var ss: TextEditor.Snapshot?
    
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

func testMemento() {
    
    let te = TextEditor()
    te.setText(txt: "1233")
    
    print(te.getText() ?? "")
    
    let c = Command(edit: te)
    c.makeBackup()
    c.excute()
    
    print(te.getText() ?? "")
    
    c.undo()
    print(te.getText() ?? "")
    
    
}
