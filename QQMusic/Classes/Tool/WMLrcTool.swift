//
//  WMLrcTool.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//用于歌词解析的工具类

import UIKit

class WMLrcTool: NSObject {

    /// 根据歌词名称来返回该歌词的对象数组(歌词每一行)
    class func lrc(with name: String) -> [WMLrcLine] {
        //获取歌曲
        let lrcPath = Bundle.main.path(forResource: name, ofType: nil)
        //承载转换的模型
        var tempArr = [WMLrcLine]()
        //获取歌词的数组
        do{
             let lrcString = try String(contentsOfFile: lrcPath!)
             //拿到歌词的数组
            let lrcArr = lrcString.components(separatedBy: "\n")
            
             for  lrcLineString in lrcArr {
                
                if  lrcLineString.hasPrefix("[ti:") || lrcLineString.hasPrefix("[ar:") || lrcLineString.hasPrefix("[al:") || !lrcLineString.hasPrefix("["){
                    continue
                }
                let lrcLine = WMLrcLine(text: lrcLineString)
                tempArr.append(lrcLine)
            }
        } catch {
            print("这里真的没有了啊")
        }
        return tempArr
    }
}
