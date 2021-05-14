//
//  AbstractFactroy.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/3/31.
//

import Foundation

protocol Keyboard {
    func printSelf();
}

protocol Mouse {
    func printSelf();
}

protocol Factory {
    func productKeyboard() -> Keyboard;
    func productMouse() -> Mouse;
}

enum AbstractFactorySpace {
    class XiaomiFactory: Factory {
        func productKeyboard() -> Keyboard {
            return XiaomiKeyboard();
        }
        func productMouse() -> Mouse {
            return XiaomiMouse()
        }
    }
    
    class HPFactory: Factory {
        func productKeyboard() -> Keyboard {
            return HPKeyboard();
        }
        func productMouse() -> Mouse {
            return HPMouse();
        }
    }

    class XiaomiKeyboard: Keyboard {
        func printSelf() {
            print("小米键盘");
        }
    }

    class XiaomiMouse: Mouse {
        func printSelf() {
            print("小米鼠标");
        }
    }

    class HPKeyboard: Keyboard {
        func printSelf() {
            print("惠普键盘");
        }
    }

    class HPMouse: Mouse {
        func printSelf() {
            print("惠普鼠标");
        }
    }
}




func AbstractFactory() {
    let f1 = AbstractFactorySpace.XiaomiFactory();
    let k1 = f1.productKeyboard();
    let f2 = AbstractFactorySpace.XiaomiFactory();
    let m2 = f2.productMouse();
    k1.printSelf();
    m2.printSelf();
}
