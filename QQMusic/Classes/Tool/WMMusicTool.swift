//
//  WMMusicTool.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//用于音乐播放操作的工具类

import UIKit

class WMMusicTool: NSObject {
    
    static var _musics:NSArray?
    static var _playingMusic:WMMusic?
    //数据的初始化加载
    override class func initialize() {
        //对数据进行加载
        if _musics == nil {
            let urlPath = NSBundle.mainBundle().pathForResource("Musics.plist", ofType: nil)
            let songList = NSArray(contentsOfFile: urlPath!)
            let musicArray = NSMutableArray()
            //对数据进行便利
            for  musicDict in songList! {
                let music = WMMusic()
                music.setValuesForKeysWithDictionary(musicDict as! [String : AnyObject])
                musicArray.addObject(music)
            }
            _musics = musicArray
        }
        //设置默认播放歌曲
        if _playingMusic == nil {
            _playingMusic = _musics![5] as? WMMusic
        }
    }
}
//MARK: 设置当前的初始化方法
extension WMMusicTool {
    /**设置当前播放歌曲*/
    class func playerMusic() ->WMMusic {
        return _playingMusic!
    }
    /**设置播放的歌曲*/
    class func setPlayingMusic(playingMusic:WMMusic) {
        _playingMusic = playingMusic
    }
    
    /**下一首歌曲*/
    class func nextMusic() ->WMMusic {
        var currentIndex = _musics?.indexOfObject(_playingMusic!)
        
        var nextIndex  = ++currentIndex!
        //如果是大于数组的数量，清零开始
        if nextIndex >= _musics?.count {
            nextIndex = 0
        }
        let nextMusic = _musics![nextIndex] as! WMMusic
        
        return nextMusic
    }
    /**上一首的歌曲*/
    class func previousMusic() ->WMMusic {
        var currentIndex = _musics?.indexOfObject(_playingMusic!)
        
        var previousIndex  = --currentIndex!
        //如果是小于当前长度的话，则从末尾开始
        if previousIndex < 0 {
            previousIndex = _musics!.count - 1
        }
        let previousMusic = _musics![previousIndex] as! WMMusic
       
        return previousMusic
    }
}
