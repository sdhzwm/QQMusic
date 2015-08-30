//
//  WMBackPalyTool.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/30.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
class WMBackPalyTool: NSObject {

    /// 设置后台播放
    class func setupBackPlay() {
        //获取音频回话
        let session = AVAudioSession.sharedInstance()
        //设置后台播放
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        //激活后台播放
        try! session.setActive(true)
    }
    /// 设置后台播放的一些列设置
    class func setupLockScreenInfoWithLockImage(lockImage:UIImage,duration:NSTimeInterval, currTime: NSTimeInterval) {
        //获取当前播放的歌曲
        let playingMusic = WMMusicTool.playerMusic()
        //获取锁屏界面中心
        let playingInfoCenter = MPNowPlayingInfoCenter.defaultCenter()
        //设置需要展示的信息
        let artWord = MPMediaItemArtwork(image: lockImage)
        
        let playingInfo = [
            MPMediaItemPropertyAlbumTitle: playingMusic.name!,
            MPMediaItemPropertyAlbumArtist: playingMusic.singer!,
            MPMediaItemPropertyArtwork: artWord,
            MPMediaItemPropertyPlaybackDuration: duration,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: currTime
        ]
        playingInfoCenter.nowPlayingInfo = playingInfo
        //接受远程事件
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()

    }
}
