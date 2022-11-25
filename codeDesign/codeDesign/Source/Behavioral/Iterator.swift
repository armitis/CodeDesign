//
//  Iterator.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/8/27.
//

import Foundation

class Person {
    var name = ""
    let id: String
    
    init(_ n: String, _ id: String) {
        self.name = n
        self.id = id
    }
    
    func printSelf() {
        print("\(self.name)")
    }
}

protocol SocailNetwork {
    func createFriendsIterator(id: String) -> PersonIterator
    func createCoworkersIterator(id: String) -> PersonIterator
    
}

protocol PersonIterator {
    
    func hasMore() -> Bool;
    func getNext() -> Person?;
}

class Spammer {
    
    var iterator: PersonIterator?
    
    func sendMessage(msg: String) {
        guard let i = self.iterator else {
            return
        }
        while i.hasMore() {
            print("给 \(i.getNext()?.name ?? "") 发消息: \(msg)")
        }
    }
}

class Facebook: SocailNetwork {
    
    func createFriendsIterator(id: String) -> PersonIterator {
        return FacebookIterator(fb: self, type: "friends", id: id)
    }
    
    func createCoworkersIterator(id: String) -> PersonIterator {
        return FacebookIterator(fb: self, type: "coworkers", id: id)
    }
    
    func personArrayWithId(id: String, type: String) -> [Person] {
        let p1 = Person("\(type)张三", "11")
        let p2 = Person("\(type)李四", "12")
        let p3 = Person("\(type)王五", "13")
        return [p1, p2, p3]
    }
}

class FacebookIterator: PersonIterator {
    
    let facebook: Facebook
    let type: String
    let id: String
    
    var persons = [Person]()
    
    var index = 0;
    
    init(fb: Facebook, type: String, id: String) {
        self.facebook = fb
        self.type = type
        self.id = id
        self.index = 0
    }
    
    func hasMore() -> Bool {
        if self.persons.count == 0 {
            self.persons = self.facebook.personArrayWithId(id: self.id, type: self.type)
        }
        
        return index <= self.persons.count - 1
    }
    
    func getNext() -> Person? {
        if hasMore() {
            index += 1
            return self.persons[index - 1]
        }
        return nil
    }
    
    
}

func testIterator() {
    let fb = Facebook()
    let friendsIterator = fb.createFriendsIterator(id: "1")
    let sp = Spammer()
    sp.iterator = friendsIterator
    sp.sendMessage(msg: "来玩游戏")
    
    let coworkersIterator = fb.createCoworkersIterator(id: "2")
    sp.iterator = coworkersIterator
    sp.sendMessage(msg: "来工作")
    
}
