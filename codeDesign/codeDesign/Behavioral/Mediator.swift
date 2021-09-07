//
//  Mediator.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/9/7.
//

import Foundation

class MediatorComponent {
    var mediator: Mediator?
}

class ComponentButton: MediatorComponent {
    
    func click() {
        guard let m = self.mediator else {
            return
        }
        m.notify(component: self, event: "click")
    }
}

class ComponentTextField: MediatorComponent {
    var text: String = ""
    
    func textChange() {
        guard let m = self.mediator else {
            return
        }
        m.notify(component: self, event: "textChanged")
    }
}

class ComponentCheckbox: MediatorComponent {
    var checked: Bool = false
    
    func checkChanged() {
        guard let m = self.mediator else {
            return
        }
        m.notify(component: self, event: "checkChanged")
    }
}

protocol Mediator {
    
    func notify(component: MediatorComponent, event: String)
}


class Dialog: Mediator {
    
    let loginButton: ComponentButton
    let nameTextField: ComponentTextField
    let passwordTextField: ComponentTextField
    let isLoginCheckBox: ComponentCheckbox
    
    init() {
        self.loginButton = ComponentButton()
        self.nameTextField = ComponentTextField()
        self.passwordTextField = ComponentTextField()
        self.isLoginCheckBox = ComponentCheckbox()
        
        self.loginButton.mediator = self
        self.nameTextField.mediator = self
        self.passwordTextField.mediator = self
        self.isLoginCheckBox.mediator = self
    }
    
    
    func notify(component: MediatorComponent, event: String) {
        if component == self.loginButton, event == "click" {
            if self.isLoginCheckBox.checked {
                if self.nameTextField.text.count > 0, self.passwordTextField.text.count > 0 {
                    print("登录成功")
                } else {
                    print("请填写用户名或者密码")
                }
            } else {
                print("开始注册")
            }
        }
        if component == self.nameTextField, event == "textChanged" {
            if self.nameTextField.text.count == 0 {
                print("请填写用户名")
            }
            if self.nameTextField.text.count > 10 {
                print("用户名长度不能超过10个字符")
            }
        }
        if component == self.passwordTextField, event = "textChanged" {
            if self.passwordTextField.text.count == 0 {
                print("用户密码不能为空")
            }
            if self.passwordTextField.text.count < 8 {
                print("用户密码不能少于8位")
            }
        }
    }
}

func testMediator() {
    let d = Dialog()
    d.isLoginCheckBox = true
    d.passwordTextField.text = "123"
    d.loginButton.click()
    
    d.nameTextField.text = "张三"
    d.loginButton.click()
    
    d.passwordTextField.text = "123456789"
    d.loginButton.click()
}
