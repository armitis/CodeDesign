//
//  State.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2021/9/23.
//

import Foundation

class State {
    
    let player: VideoPlayer
    
    init(p: VideoPlayer) {
        self.player = p
    }
    
    func playClick() {}
    
    func lockClick() {}
    
    func nextClick() {}
    
    func previousClick() {}
}

class PlayState: State {
    
    override func playClick() {
        self.player.resetState(ReadyState(p: self.player))
        self.player.stopPlay()
    }
    
    override func lockClick() {
        self.player.resetState(LockedState(p: self.player))
        self.player.lock()
    }
    
    override func nextClick() {
        self.player.next()
    }
    
    override func previousClick() {
        self.player.previous()
    }
    
    
}

class ReadyState: State {
    override func playClick() {
        self.player.resetState(PlayState(p: self.player))
        self.player.startPlay()
    }
    
    override func lockClick() {
        self.player.resetState(LockedState(p: self.player))
        self.player.lock()
    }
    
    override func nextClick() {
        self.player.resetState(PlayState(p: self.player))
        self.player.next()
    }
    
    override func previousClick() {
        self.player.resetState(PlayState(p: self.player))
        self.player.previous()
    }
    
    
}

//这里为了更方便说明问题，假设锁屏状态下，除了解锁操作，其他操作都被禁用
class LockedState: State {
    
    override func playClick() {
        print("锁屏状态。。")
    }
    
    override func lockClick() {
        if self.player.isPlaying {
            self.player.resetState(PlayState(p: self.player))
        } else {
            self.player.resetState(ReadyState(p: self.player))
        }
        self.player.unlock()
    }
    
    override func nextClick() {
        print("锁屏状态。。")
    }
    
    override func previousClick() {
        print("锁屏状态。。")
    }
    
    
}





class VideoPlayer {
    
    
    private var state: State?
    
    
    init() {
        
    }
    
    func resetState(_ state: State) {
        self.state = state
    }
    
    
    func playClick() {
        self.state?.playClick()
    }
    
    func lockClick() {
        self.state?.lockClick()
    }
    
    func nextClick() {
        self.state?.nextClick()
    }
    
    func previousClick() {
        self.state?.previousClick()
    }
    
    func startPlay() {
        print("开始播放")
    }
    
    func stopPlay() {
        print("暂停播放")
    }
    
    func lock() {
        print("锁屏")
    }
    
    func unlock() {
        print("解锁")
    }
    
    func next() {
        print("下一首")
    }
    
    func previous() {
        print("上一首")
    }
}

func testState() {
    
    let player = VideoPlayer()
    player.resetState(ReadyState(p: player))
    
    player.playClick()
    player.nextClick()
    player.playClick()
    player.lockClick()
    player.previousClick()
    player.lockClick()
    player.previousClick()
}
