//
//  FactoryMethod.swift
//  Design-Patterns
//
//  Created by 郑智文 on 2018/12/13.
//  Copyright © 2018 郑智文. All rights reserved.
//

import Foundation

protocol LogFactory {
    init()
    func createLog() -> Log
}

protocol Log {
    func writeLog()
}

enum FactoryMethodSpace {
    @objc(FileLogFactory)
    class FileLogFactory: NSObject, LogFactory {
        func createLog() -> Log {
            return FileLog()
        }
        
      override  required init() {
            
        }
    }
    
    @objc(DatabaseLogFactory)
    class DatabaseLogFactory: NSObject, LogFactory {
        func createLog() -> Log {
            return DatabaseLog()
        }
        
       override required init() {
            
        }
    }
    
    class FileLog: Log {
        func writeLog() {
            print("FileLog write")
        }
    }
    
    class DatabaseLog: Log {
        func writeLog() {
            print("DatabaseLog write")
        }
    }
    
    class FactoryConfig {
        
        static func factory(_ name: String) -> LogFactory? {
            if let type = NSClassFromString(name) as? LogFactory.Type {
                return type.init()
            }
            return nil
        }
    }
    
    static func run() {
        //知道工厂类型
        FileLogFactory().createLog().writeLog()
        DatabaseLogFactory().createLog().writeLog()
        //里氏替换
        var factory: LogFactory = FileLogFactory()
        factory.createLog().writeLog()
        factory = DatabaseLogFactory()
        factory.createLog().writeLog()
        //动态配置
        FactoryConfig.factory("FileLogFactory")?.createLog().writeLog()
        FactoryConfig.factory("DatabaseLogFactory")?.createLog().writeLog()
    }
}
