//
//  WMAudioTool.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//用于音乐播放器的工具类

import UIKit
import AVFoundation
class WMAudioTool: NSObject {
    
    static var  playSongs = [String: AVAudioPlayer]()
    
    /**播放音乐*/
    @discardableResult
    class func playMusic(with name: String) -> AVAudioPlayer {
        var audioPlayer:AVAudioPlayer?
        audioPlayer = playSongs[name]
        
        if audioPlayer == nil, let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) {
            //去创建对应的播放器
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: fileUrl)
                playSongs[name] = audioPlayer
                audioPlayer!.prepareToPlay()
            } catch {
                print("臣妾真的不想来这里")
            }
        }
        audioPlayer!.play()
        return audioPlayer!
    }
    
    /**暂停音乐*/
    class func pauseMusic(with name: String) {
        if let player = playSongs[name] {
            player.pause()
        }
    }
    
    /**停止音乐*/
    class func stopMusic(with name: String) {
        if let player = playSongs[name] {
            player.stop()
            playSongs[name] = nil
        }

    }

}
