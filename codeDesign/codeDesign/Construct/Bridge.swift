//
//  Bridge.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/4/17.
//

import Foundation

protocol Device {
    func getVolumn() -> Int;
    func setVolumn(volumn: Int);
    func getChannel() -> Int;
    func setChannel(channel: Int);
    func enable();
    func disable();
    func isEnable() -> Bool;
    func printSelf();
}

protocol RemoteControl {
    func setupDevice(device: Device);
    func powChange();
    func channelUp();
    func channelDown();
    func volumnUp();
    func volumnDown();
}

class DeviceControl: RemoteControl {
    
    var device: Device?
    
    func setupDevice(device: Device) {
        self.device = device;
    }
    
    func powChange() {
        guard let d = self.device else {
            return;
        }
        if d.isEnable() {
            d.disable()
        } else {
            d.enable()
        }
    }
    
    func channelUp() {
        guard let d = self.device else {
            return;
        }
        let c = d.getChannel();
        d.setChannel(channel: c + 1);
    }
    
    func channelDown() {
        guard let d = self.device else {
            return
        }
        let c = d.getChannel();
        d.setChannel(channel: c - 1);
    }
    
    func volumnUp() {
        guard let d = self.device else {
            return
        }
        let v = d.getVolumn()
        d.setVolumn(volumn: v + 1)
    }
    
    func volumnDown() {
        guard let d = self.device else {
            return
        }
        let v = d.getVolumn()
        d.setVolumn(volumn: v - 1)
    }
}

class AdvanceControl: DeviceControl {
    func mute() {
        guard let d = self.device else {
            return
        }
        d.setVolumn(volumn: 0)
    }
}

class FM: Device {
    
    var volumn: Int = 0;
    var channel: Int = 1;
    var enabled: Bool = true;
    
    func getVolumn() -> Int {
        return self.volumn
    }
    
    func setVolumn(volumn: Int) {
        self.volumn = volumn
    }
    
    func getChannel() -> Int {
        return self.channel
    }
    
    func setChannel(channel: Int) {
        self.channel = channel
    }
    
    func enable() {
        self.enabled = true
    }
    
    func disable() {
        self.enabled = false
    }
    
    func isEnable() -> Bool {
        return self.enabled
    }
    
    func printSelf() {
        print("收音机 音量是: \(self.volumn), 频道是: \(self.channel), 是否开机: \(self.enabled)")
    }
    
    
}

class TV: Device {
    
    var volumn: Int = 0;
    var channel: Int = 1;
    var enabled: Bool = true;
    
    func getVolumn() -> Int {
        return self.volumn
    }
    
    func setVolumn(volumn: Int) {
        self.volumn = volumn
    }
    
    func getChannel() -> Int {
        return self.channel
    }
    
    func setChannel(channel: Int) {
        self.channel = channel
    }
    
    func enable() {
        self.enabled = true
    }
    
    func disable() {
        self.enabled = false
    }
    
    func isEnable() -> Bool {
        return self.enabled
    }
    
    func printSelf() {
        print("电视机 音量是: \(self.volumn), 频道是: \(self.channel), 是否开机: \(self.enabled)")
    }
}


func testBridge() {
    
    let control = DeviceControl()
    let advanceControl = AdvanceControl()
    let tv = TV()
    let fm = FM()
    control.setupDevice(device: tv)
    control.volumnUp()
    control.channelUp()
    control.powChange()
    tv.printSelf()
    
    control.setupDevice(device: fm)
    control.volumnUp()
    control.channelUp()
    control.powChange()
    fm.printSelf()
    
    advanceControl.setupDevice(device: fm)
    advanceControl.volumnUp()
    advanceControl.channelUp()
    advanceControl.powChange()
    advanceControl.mute()
    fm.printSelf()
    
    advanceControl.setupDevice(device: tv)
    advanceControl.volumnUp()
    advanceControl.channelUp()
    advanceControl.powChange()
    advanceControl.mute()
    tv.printSelf()
}
