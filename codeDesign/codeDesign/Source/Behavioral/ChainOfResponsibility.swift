//
//  ChainOfResponse.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/6/4.
//

import Foundation

protocol ContextHelperProtocol {
    func showHelp()
}

enum ChainOfResponsibility {
    
    class Component: ContextHelperProtocol {
        
        var helpTip: String?
        var parent: Component?
        
        init(tp: String?) {
            self.helpTip = tp;
        }
        
        func showHelp() {
            if let t = self.helpTip {
                print("\(t)")
                return
            }
            if let p = self.parent {
                p.showHelp()
            }
        }
    }
    
    class Container: Component {
        
        var children = [Component]()
        
        func add(c: Component) {
            self.children.append(c)
            c.parent = self
        }
        
    }
    
    class Button: Component {
        
    }
    
    class Panel: Container {
        
    }
    
    class Dialog: Container {
        
    }
}

func testChain() {
    
    let confirm = ChainOfResponsibility.Button(tp: "确定按钮")
    let cancel = ChainOfResponsibility.Button(tp: "取消按钮")
    let panelButton = ChainOfResponsibility.Button(tp: nil)
    let panel = ChainOfResponsibility.Panel(tp: "面板")
    let dialog = ChainOfResponsibility.Dialog(tp: "对话框")
    
    panel.add(c: confirm)
    panel.add(c: cancel)
    panel.add(c: panelButton)
    dialog.add(c: panel)
    
    confirm.showHelp()
    panelButton.showHelp()
}

