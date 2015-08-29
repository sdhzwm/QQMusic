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
    
    static var  playSongs = NSMutableDictionary()
    
    /**播放音乐*/
    class func playMusicWithMusicName(musicName:String) ->AVAudioPlayer {
        
        var audioPlayer:AVAudioPlayer?
        audioPlayer = playSongs[musicName] as? AVAudioPlayer
        
        if audioPlayer == nil {
            let fileUrl = NSBundle.mainBundle().URLForResource(musicName, withExtension: nil)
            if fileUrl != nil {
                //去创建对应的播放器
                do{
                    audioPlayer = try AVAudioPlayer(contentsOfURL: fileUrl!)
                    playSongs.setObject(audioPlayer!, forKey: musicName)
                    audioPlayer!.prepareToPlay()
                    
                }catch{
                    print("臣妾真的不想来这里")
                }                
            }
        }
        audioPlayer!.play()
        return audioPlayer!
    }
    /**暂停音乐*/
    class func pauseMusicWithMusicName(musicName:String) {
        let player = playSongs[musicName];
        
        if (player != nil) {
            player?.pause()
        }
    }
    /**停止音乐*/
    class func stopMusicWithMusicName(musicName:String) {
       
        var player = playSongs[musicName];
        if (player != nil) {
            player!.player
            playSongs.removeObjectForKey(musicName)
            player = nil;
        }

    }

}
