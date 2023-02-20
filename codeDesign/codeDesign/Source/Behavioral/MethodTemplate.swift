//
//  MethodTemplate.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2021/9/27.
//

import Foundation

class HouseBuilder {
    
    var window: String = ""
    var door: String = ""
    var wall: String = ""
    var floor: String = ""
    var roof: String = ""
    
    func build() {
        self.buildFloor()
        self.buildWall()
        self.buildRoof()
        self.buildWindow()
        self.buildDoor()
    }
    
    func buildWindow() {
        self.window = "没有窗户"
    }
    
    func buildDoor() {
        self.door = "原始的洞穴作为门"
    }
    
    func buildWall() {
        self.wall = "原生的泥土做的墙"
    }
    
    func buildFloor() {
        self.floor = "原生的泥土做的地板"
    }
    
    func buildRoof(){
        self.roof = "原生的泥土做的屋顶"
    }
    
    func pringSelf()  {
        print("\(self.floor), \(self.wall), \(self.window), \(self.door), \(self.roof)")
    }
    
}

class FarmingHouseBuilder: HouseBuilder {
    
    override func buildWindow() {
        self.window = "纸做的窗户"
    }
    
    override func buildDoor() {
        self.door = "木头门"
    }
    
    override func buildRoof() {
        self.roof = "木头做的房顶"
    }
    
}

class IndustryHouseBuilder: HouseBuilder {
    
    override func buildWindow() {
        self.window = "玻璃窗户"
    }
    
    override func buildDoor() {
        self.door = "防盗门"
    }
    
    override func buildWall() {
        self.wall = "水泥做的墙"
    }
    
    override func buildFloor() {
        self.floor = "木地板"
    }
    
    override func buildRoof() {
        self.roof = "水泥房顶 + 吊顶"
    }
}


func testMethodTemplate() {
    
    let primevalHouseBuilder = HouseBuilder()
    primevalHouseBuilder.build()
    primevalHouseBuilder.pringSelf()
    
    let farmBuilder = FarmingHouseBuilder()
    farmBuilder.build()
    farmBuilder.pringSelf()
    
    let industryBuilder = IndustryHouseBuilder()
    industryBuilder.build()
    industryBuilder.pringSelf()
}
