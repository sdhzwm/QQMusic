//
//  WMExtens.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

extension TimeInterval {
    var lrcTimeString: String {
        let min = self / 60
        let seconde = truncatingRemainder(dividingBy: 60)
        return String(format: "%02.f:%02.f",min,seconde)
    }
}


 extension String {
    
    var lrcTime: TimeInterval {
        let temStrings = components(separatedBy: ":")
        let min = Double(temStrings[0])!
        let second = Double(temStrings[1].components(separatedBy: ".")[0])!
        let millisecond = Double(temStrings[1].components(separatedBy: ".")[1])!
        return (min * 60 + second + millisecond * 0.01)
    }
    
}

extension CALayer {
    /**暂停动画*/
    func pauseAnimate(){
        
        let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    /**恢复动画*/
    func resumeAnimate(){
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
    }
}
extension UIImage {
    /**
    根据文字的高度和传来的文字来生成水印文字
    
    :param: titleH      文字的高度
    :param: currText    中间行的文字
    :param: prevousText 上一行
    :param: nextText    下一行
    
    :returns: 返回的图片
    */
    func setImage(titleH: CGFloat, currText: String, prevousText: String?, nextText: String?) -> UIImage {
        //获取图像上下文
        UIGraphicsBeginImageContext(size)
        //将图像画上去
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let style = NSMutableParagraphStyle()
        
        style.alignment = .center
        let currTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor: UIColor(red: 38/255.0, green: 187/255.0, blue: 102/255.0, alpha: 1.0),
            NSAttributedStringKey.paragraphStyle: style
        ]
    
        let otherTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.paragraphStyle: style
        ]
        //当前行
        currText.draw(in: CGRect(x: 0, y: size.height - (titleH * 2), width: size.width, height: size.height), withAttributes: currTextAttributes)
        prevousText?.draw(in: CGRect(x: 0, y: size.height - (titleH * 3), width: size.width, height: size.height), withAttributes: otherTextAttributes)
        nextText?.draw(in: CGRect.init(x: 0, y: size.height - titleH, width: size.width, height: size.height), withAttributes: otherTextAttributes)
        //生成图片
        let textImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
       return textImage!
    }
}

