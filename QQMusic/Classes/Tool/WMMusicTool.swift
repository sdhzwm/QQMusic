//
//  WMMusicTool.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//用于音乐播放操作的工具类

import UIKit

class WMMusicTool: NSObject {
    
    var musics = [WMMusic]()
    var playingMusic: WMMusic?
    
    static let shared = WMMusicTool()
    private override init() {
        super.init()
        initData()
    }
    
        //数据的初始化加载
    func initData() {
        //对数据进行加载
        let urlPath = Bundle.main.path(forResource: "Musics.plist", ofType: nil)
        let songList = NSArray(contentsOfFile: urlPath!) as! [[String: String]]
        //对数据进行遍历
        for  dic in songList {
            let music = WMMusic(name: dic["name"], filename: dic["filename"], lrcname: dic["lrcname"], singer: dic["singer"], singerIcon: dic["singerIcon"], icon: dic["icon"])
            musics.append(music)
        }

        //设置默认播放歌曲
        playingMusic = musics[5]
    }
}
//MARK: 设置当前的初始化方法
extension WMMusicTool {
    /**设置当前播放歌曲*/
    func playerMusic() ->WMMusic {
        return playingMusic!
    }
    /**设置播放的歌曲*/
    func setPlayingMusic(playingMusic:WMMusic) {
        self.playingMusic = playingMusic
    }
    
    /**下一首歌曲*/
    func nextMusic() -> WMMusic {
        var playIndex = nextIndex
        //如果是大于数组的数量，清零开始
        if playIndex >= musics.count {
            playIndex = 0
        }
        let nextMusic = musics[playIndex]
        
        return nextMusic
    }
    /**上一首的歌曲*/
    func previousMusic() -> WMMusic {
                var playIndex = previousIndex
        //如果是小于当前长度的话，则从末尾开始
        if playIndex < 0 {
            playIndex = musics.count - 1
        }
        let previousMusic = musics[playIndex]
       
        return previousMusic
    }
    
    var currentIndex: Int {
        var currentIndex = 0
        for (index, music) in musics.enumerated() {
            if music.name == playingMusic?.name {
                currentIndex = index
                break
            }
        }
        return currentIndex
    }
    
    var previousIndex: Int {
        return currentIndex - 1
    }
    
    var nextIndex: Int {
        return currentIndex + 1
    }
    
}
