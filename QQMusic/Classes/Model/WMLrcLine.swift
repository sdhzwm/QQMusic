//
//  WMLrcLine.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/29.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

struct WMLrcLine {
    /// 歌词的文字
    var text: String
    /// 该行歌词的时间
    var time: TimeInterval
}

extension WMLrcLine {
    
    init(text: String) {
        let lrcArr = text.components(separatedBy: "]")
        time = String(lrcArr[0].dropFirst()).lrcTime
        self.text = lrcArr[1]
    }

}
