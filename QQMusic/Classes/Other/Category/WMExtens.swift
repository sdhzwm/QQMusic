//
//  WMExtens.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit


extension NSString {
    class func stringWithTime(time: NSTimeInterval) ->String {
        let min = time / 60
        let seconde = time % 60
        
        return String(format: "%02.f:%02.f",min,seconde)
    }
    
   class func timeStringWithString(timeString: NSString) ->NSTimeInterval {
    
        let min = Double(timeString.componentsSeparatedByString(":")[0])
        let second = Double(timeString.substringWithRange(NSMakeRange(3, 2)))
        let haomiao = Double(timeString.componentsSeparatedByString(".")[1])
        return (min! * 60 + second! + haomiao! * 0.01)
    }
    
//    NSInteger second = [[timeString substringWithRange:NSMakeRange(3, 2)] integerValue];
//    NSInteger haomiao = [[timeString componentsSeparatedByString:@"."][1] integerValue];
//    
//    return (min * 60 + second + haomiao * 0.01);
//    }
}

extension CALayer {
    /**暂停动画*/
    func pauseAnimate(){
        
        let pausedTime = convertTime(CACurrentMediaTime(), fromLayer: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    /**恢复动画*/
    func resumeAnimate(){
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause = convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        beginTime = timeSincePause
    }
}