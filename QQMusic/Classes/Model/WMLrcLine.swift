//
//  WMLrcLine.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/29.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcLine: NSObject {
     /// 歌词的文字
        var lrcText: String?
     /// 该行歌词的时间
        var lrcTime: NSTimeInterval?
    
    private func initWithLrclineString(lrcText: String) ->WMLrcLine {

        let lrcLine = WMLrcLine()
        let lrcArr = lrcText.componentsSeparatedByString("]")
        let timeString:NSString = lrcArr[0]
        lrcLine.lrcTime = NSString.timeStringWithString(timeString.substringFromIndex(1))
        lrcLine.lrcText = lrcArr[1]
        
        return lrcLine
    }
    
   class func lrcLineWithLrclineString(lrcText: String) ->WMLrcLine{
        let lrcLine = WMLrcLine()
        return lrcLine.initWithLrclineString(lrcText)
    }
    
}
