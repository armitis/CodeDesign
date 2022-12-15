//
//  Command.swift
//  codeDesign
//
//  Created by 郑智文 on 2021/7/18.
//

import Foundation

class BaseCommand {
    
    let app: Application
    let editor: Editor
    var backup: String?
    
    var selfDescription: String?
    
    init(a: Application,e: Editor) {
        self.editor = e
        self.app = a
    }
    
    func excute() -> Bool  {
//        printSelf()
        return false
    }
    
    func undo() {
        self.editor.content = self.backup
    }
    
    func saveBackup(_ backup: String?) {
        if let c = backup {
            self.backup = c
        }
    }
    
    func printSelf() {
        
    }
    
}

class CopyCommand: BaseCommand {
    
    override func excute() -> Bool {
        self.app.clipboard = self.editor.content
        return false
    }
    
    override func printSelf() {
        print("复制: \(self.editor.content ?? "")")
    }
}

class ClipCommand: BaseCommand {
    
    override func excute() -> Bool {
        self.saveBackup(self.editor.content)
        self.app.clipboard = self.editor.content
        self.editor.content = nil
        return true
    }
    
    override func printSelf() {
        print("剪切: \(self.editor.content ?? "")")
    }
}

class PasteCommand: BaseCommand {
    
    override func excute() -> Bool {
        self.saveBackup(self.editor.content)
        if let c = self.app.clipboard {
            self.editor.content = c
        }
        return true
    }
    
    override func printSelf() {
        print("粘贴: \(self.app.clipboard ?? "")")
    }
}

class UndoCommand: BaseCommand {
    
    override func excute() -> Bool {
        self.app.undo()
        return true
    }
    
    override func printSelf() {
        print("撤销")
    }
}


class CommandHistory {
    
    var commands: [BaseCommand]
    
    init() {
        self.commands = [BaseCommand]()
    }
    
    func push(_ command: BaseCommand) {
        self.commands.append(command)
    }
    
    func pop() -> BaseCommand? {
        if let c = self.commands.last {
            self.commands.removeLast()
            return c
        }
        return nil
    }
}

class Button {
    
    var actionType:String
    var command: BaseCommand?
    
    init(at: String) {
        self.actionType = at
    }
}

class QuickKeyboard {
    
    var actionType:String
    var command: BaseCommand?
    
    init(at: String) {
        self.actionType = at
    }
}

class Application {
    
    var clipboard: String?
    let editor: Editor
    let history: CommandHistory
    
    let copyButton: Button
    let pasteButton: Button
    let clipButton: Button
    let undoButton: Button
    let copyKeyboard: QuickKeyboard
    let pasteKeyboard: QuickKeyboard
    let clipKeyboard: QuickKeyboard
    let undoKeyboard: QuickKeyboard
    
    init() {
        self.editor = Editor()
        self.history = CommandHistory()
        
        self.copyButton = Button(at: "copy")
        self.pasteButton = Button(at: "past")
        self.clipButton = Button(at: "clip")
        self.undoButton = Button(at: "undo")
        
        self.copyKeyboard = QuickKeyboard(at: "copy")
        self.pasteKeyboard = QuickKeyboard(at: "past")
        self.clipKeyboard = QuickKeyboard(at: "clip")
        self.undoKeyboard = QuickKeyboard(at: "undo")
        
        let copyCommand = CopyCommand(a: self, e: self.editor)
        let pasteCommand = PasteCommand(a: self, e: self.editor)
        let clipComamnd = ClipCommand(a: self, e: self.editor)
        let undoCommand = UndoCommand(a: self, e: self.editor)
        
        self.copyButton.command = copyCommand
        self.copyKeyboard.command = copyCommand
        
        self.pasteButton.command = pasteCommand
        self.pasteKeyboard.command = pasteCommand
        
        self.clipButton.command = clipComamnd
        self.clipKeyboard.command = clipComamnd
        
        self.undoButton.command = undoCommand
        self.undoKeyboard.command = undoCommand
        
    }
    
    func excute(_ command: BaseCommand?) {
        if let c = command, c.excute() {
            self.history.push(c)
        }
    }
    
    func undo() {
        if let c = self.history.pop() {
            c.undo()
        }
    }
}

class Editor {
    var content: String?
}

func testCommand() {
    
    let app = Application()
    
    app.editor.content = "初始化1"
    app.excute(app.clipButton.command)
    print("\(app.editor.content ?? "无")")
    app.excute(app.undoKeyboard.command)
    print("\(app.editor.content ?? "无")")
    
    app.excute(app.copyButton.command)
    app.editor.content = "abc"
    app.excute(app.pasteButton.command)
    print("\(app.editor.content ?? "无")")
    
    app.excute(app.undoKeyboard.command)
    print("\(app.editor.content ?? "无")")
}



