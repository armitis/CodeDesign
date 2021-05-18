//
//  FactroyMethod.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/3/31.
//

import Foundation

protocol Computer {
    func screen() -> String;
    func keyboard() -> String;
    func mouse() -> String;
    func mainMachine() -> String;
    
    func printSelf();
}

extension Computer {
    func printSelf() {
        print("\(self.screen()), \(self.keyboard()), \(self.mouse()), \(self.mainMachine())");
    }
}

protocol ComputerFactory {
    func product() -> Computer;
}

enum FactoryMethodSpace {
    class XiaomiFactory: ComputerFactory {
        func product() -> Computer {
            return XiaomiComputer();
        }
    }

    class HPFactory: ComputerFactory {
        func product() -> Computer {
            return HPComputer();
        }
    }

    class XiaomiComputer: Computer {
        func screen() -> String {
            return "小米屏幕";
        }
        
        func keyboard() -> String {
            return "小米键盘";
        }
        
        func mouse() -> String {
            return "小米鼠标";
        }
        
        func mainMachine() -> String {
            return "小米机器";
        }
    }

    class HPComputer: Computer {
        func screen() -> String {
            return "惠普屏幕";
        }
        
        func keyboard() -> String {
            return "惠普键盘";
        }
        
        func mouse() -> String {
            return "惠普鼠标";
        }
        
        func mainMachine() -> String {
            return "惠普主机";
        }
    }
}




func FactoryMethod() {
    let c = FactoryMethodSpace.HPFactory().product();
    c.printSelf()
    
    let c2 = FactoryMethodSpace.XiaomiFactory().product();
    c2.printSelf()
}
