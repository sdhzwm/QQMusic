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
    class func lrcToolWithLrcName(lrcName: String) -> NSArray {
        //获取歌曲
        let lrcPath = NSBundle.mainBundle().pathForResource(lrcName, ofType: nil)
        //承载转换的模型
        let tempArr = NSMutableArray()
        //获取歌词的数组
        do{
             let lrcString = try String(contentsOfFile: lrcPath!)
             //拿到歌词的数组
             let lrcArr = lrcString.componentsSeparatedByString("\n")
            
             for  lrcLineString:NSString in lrcArr {
                
                if  lrcLineString.hasPrefix("[ti:") || lrcLineString.hasPrefix("[ar:") || lrcLineString.hasPrefix("[al:") || !lrcLineString.hasPrefix("["){
                    continue
                }
                let lrcLine = WMLrcLine.lrcLineWithLrclineString(lrcLineString as String)
                tempArr.addObject(lrcLine)
            }
        }catch{
            print("这里真的没有了啊")
        }
        return tempArr
    }
}