//
//  WMLrcLabel.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcLabel: UILabel {
    var progress: CGFloat = 0 {
        didSet {
                setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
        let fillRect = CGRect(x: 0, y: 0, width: bounds.width * (progress), height: bounds.height)
        UIColor(red: 38/255.0, green: 187/255, blue: 102/255.0, alpha: 1).set()
        UIRectFillUsingBlendMode(fillRect, .sourceIn)
    }
    
    
}
