//
//  Builder.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/4/6.
//

import Foundation

protocol BuilderProtocol {
    func reset()
    func setSeats(count: Int)
    func setEngine(engine: String)
    func setColor(color: String)
}

enum Builder {
    
    class BMWCar {
        
        var seats: Int;
        var engine: String;
        var color: String;
        
        init() {
            self.seats = 0;
            self.engine = "";
            self.color = "";
        }
        
        func printSelf() {
            print("MBW一台: \(self.seats)个座位,\(self.engine)发动机,颜色\(self.color)");
        }
    }
    
    class BMWBuilder: BuilderProtocol {
        
        var car:BMWCar;
        
        init() {
            self.car = BMWCar();
        }
        
        func reset() {
            self.car = BMWCar();
        }
        
        func setSeats(count: Int) {
            self.car.seats = count;
        }
        
        func setEngine(engine: String) {
            self.car.engine = engine;
        }
        
        func setColor(color: String) {
            self.car.color = color;
        }
        
        func product() -> BMWCar {
            return self.car;
        }
    }
    
    class Audi {
        var seats: Int;
        var engine: String;
        var color: String;
        
        init() {
            self.seats = 0;
            self.engine = "";
            self.color = "";
        }
        
        func printSelf() {
            print("Audi一台: \(self.seats)个座位,\(self.engine)发动机,颜色\(self.color)");
        }
    }
    
    class AudiBuilder: BuilderProtocol {
        
        var car: Audi;
        
        init() {
            self.car = Audi();
        }
        
        func reset() {
            self.car = Audi();
        }
        
        func setSeats(count: Int) {
            self.car.seats = count;
        }
        
        func setEngine(engine: String) {
            self.car.engine = engine;
        }
        
        func setColor(color: String) {
            self.car.color = color;
        }
        
        func product() -> Audi {
            return self.car;
        }
        
    }
    
    class Director {
        
        var builder: BuilderProtocol?
        
        init() {
            
        }
        
        func makeBMW(b: BMWBuilder) {
            self.builder = b;
        }
        
        func makeAudi(b: AudiBuilder) {
            self.builder = b
        }
        
        func productBMW() {
            self.builder?.reset();
            self.builder?.setSeats(count: 2);
            self.builder?.setEngine(engine: "4缸");
            self.builder?.setColor(color: "白色");
        }
        
        func productAudi() {
            self.builder?.reset();
            self.builder?.setSeats(count: 4);
            self.builder?.setEngine(engine: "6缸");
            self.builder?.setColor(color: "黑色");
        }
    }
}

func builder() {
    let d = Builder.Director();
    let ab = Builder.AudiBuilder();
    d.makeAudi(b: ab);
    d.productAudi();
    let audi = ab.product();
    audi.printSelf();
    
    let bmwB = Builder.BMWBuilder();
    d.makeBMW(b: bmwB);
    d.productBMW();
    let bmw = bmwB.product();
    bmw.printSelf();
}
