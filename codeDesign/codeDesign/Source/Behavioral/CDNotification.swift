//
//  CDNotification.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/9/17.
//

import Foundation

class ObserverObject:NSObject {
    
    let observer: AnyHashable
    
    let selector: Selector
    
    init(o: AnyHashable, sl: Selector) {
        self.observer = o
        self.selector = sl
    }
}

class CDNotification {
    
    static let instantance = CDNotification()
    
    private var observers = [String: NSMutableSet]()
    private var observerValueMap = [AnyHashable: ObserverObject]()
    
    private let serialQueue: dispatch_queue_serial_t
    
    init() {
        self.serialQueue = DispatchQueue(label: "ABC", qos: .default, attributes: .init(rawValue: 0), autoreleaseFrequency: .inherit, target: nil) as! dispatch_queue_serial_t
    }
    
    func addObserver(observer: AnyHashable, notificationName: String, selector: Selector) {
        self.serialQueue.async {
            let keys = self.observers.keys
            let set = NSMutableSet();
            if !keys.contains(notificationName) {
                self.observers[notificationName] = set
            }
            let ob = ObserverObject(o: observer, sl: selector)
            self.observerValueMap[observer] = ob
            if !self.observers[notificationName]!.contains(observer) {
                self.observers[notificationName]!.add(observer)
            }
        }
    }
    
    func removeObserver(observer: AnyHashable) {
        self.serialQueue.async {
            guard self.observers.values.count > 0 else {
                return
            }
            for set in self.observers.values {
                if set.contains(observer) {
                    set.remove(observer)
                }
                if let _ = self.observerValueMap[observer] {
                    self.observerValueMap.removeValue(forKey: observer)
                }
            }
        }
    }
    
    func notify(name: String) {
        self.notify(name: name, data: [:])
    }
    
    func notify(name: String, data:[String: AnyObject]) {
        self.serialQueue.async {
            guard let set = self.observers[name] else {
                return
            }
            set.enumerateObjects { (obj, pointer) in
                if let raw = obj as? NSObject, let ob = self.observerValueMap[raw],
                   raw.responds(to: ob.selector) {
                    raw.perform(ob.selector, with: data)
                }
            }
        }
    }
    
}

class TestA: NSObject {
    
    override init() {
        super.init()
        CDNotification.instantance.addObserver(observer: self, notificationName: "ABC", selector: #selector(handle))
    }
    
    @objc func handle(data: [AnyHashable: AnyObject]) {
        print("handle")
        print("\(data)")
    }
}

func testNotification() {
    
    let a = TestA()
    let data = ["name": "123" as NSString]
    CDNotification.instantance.notify(name: "ABC", data: data)
    
    
}
