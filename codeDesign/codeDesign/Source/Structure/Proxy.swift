//
//  Proxy.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/6/1.
//

import Foundation

protocol ThirdPartyYoutubeLib {
    func listVideos() -> String
    func getVideoInfo(id: String) -> String
    func downloadVideo(id: String)
}

class ThirdPartyYoutubeClass: ThirdPartyYoutubeLib {
    
    func listVideos() -> String {
        return "视频列表123123"
    }
    
    func getVideoInfo(id: String) -> String {
        return "1919"
    }
    
    func downloadVideo(id: String) {
        print("下载1919")
    }
}

class CacheThirdPartyYoutubeClass: ThirdPartyYoutubeLib {
    
    var cacheVideo:String?
    var cacheVideoList: String?
    var needReset: Bool = false
    
    let service: ThirdPartyYoutubeLib
    
    init(s: ThirdPartyYoutubeLib) {
        self.service = s
    }
    
    func listVideos() -> String {
        if cacheVideoList == nil || needReset {
            cacheVideoList = self.service.listVideos()
        }
        return cacheVideoList!
    }
    
    func getVideoInfo(id: String) -> String {
        if cacheVideo == nil || needReset {
            cacheVideo = self.service.getVideoInfo(id: "")
        }
        return cacheVideo!
    }
    
    func downloadVideo(id: String) {
        if needReset {
            self.service.downloadVideo(id: id)
        }
        if let c = self.cacheVideo, c == id {
            return
        }
        self.service.downloadVideo(id: id)
    }
}

class YoutubeManager {
    
    let s: ThirdPartyYoutubeLib
    var videoInfo: String?
    var videoList: String?
    
    init(s: ThirdPartyYoutubeLib) {
        self.s = s
    }
    
    func renderVideoPage(id: String) {
        self.videoInfo = self.s.getVideoInfo(id: id)
        print("渲染视频页: \(self.videoInfo!)")
    }
    
    func renderVideoList() {
        self.videoList = self.s.listVideos()
        print("渲染视频列表: \(self.videoList!)")
    }
    
    func reactOnUserInput() {
        renderVideoPage(id: "")
        renderVideoList()
    }
}

func testProxy() {
    
    let s = ThirdPartyYoutubeClass()
    let cs = CacheThirdPartyYoutubeClass(s: s)
    let manager = YoutubeManager(s: cs)
    manager.reactOnUserInput()
    
}
