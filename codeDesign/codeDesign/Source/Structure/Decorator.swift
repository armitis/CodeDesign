//
//  Decorator.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/5/18.
//

import Foundation


protocol DataSource {
    func read() -> String
    func write(c: String)
}

class FileDataSource: DataSource {
    
    var content: String = ""
    
    func read() -> String {
        return content
    }
    
    func write(c: String) {
        content = c
    }
}

class DataSourceDecorator: DataSource {
    
    var ds: DataSource
    
    init(data: DataSource) {
        ds = data
    }
    
    func read() -> String {
        return ds.read()
    }
    
    func write(c: String) {
        ds.write(c: c)
    }
}

class EncryptionDecorator: DataSourceDecorator {
    
    override func read() -> String {
        let s = self.ds.read()
        print("解密...")
        return s
    }
    
    override func write(c: String) {
        print("加密...")
        self.ds.write(c: c)
    }
}

class CompressionDecorator: DataSourceDecorator {
    
    override func read() -> String {
        let c = self.ds.read()
        print("解压缩...")
        return c
    }
    
    override func write(c: String) {
        print("压缩...")
        self.ds.write(c: c)
    }
}

func testDecorator() {
    
    var d:DataSource = FileDataSource()
    d.write(c: "测试数据")
    print("\(d.read())")
    
    print("\n")
    
    d = EncryptionDecorator(data: d)
    d.write(c: "测试数据")
    print("\(d.read())")
    
    print("\n")
    
    d = CompressionDecorator(data: d)
    d.write(c: "测试数据")
    print("\(d.read())")
    
}
