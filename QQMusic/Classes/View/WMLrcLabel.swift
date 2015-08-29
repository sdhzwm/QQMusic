//
//  WMLrcLabel.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcLabel: UILabel {
    var progress:CGFloat? = 0 {
        didSet {
            if let progres = progress {
                
                progress = progres

                setNeedsDisplay()
            }
        }
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let fillRect = CGRectMake(0, 0, bounds.size.width * progress!, bounds.size.height)
        
        UIColor(red: 38/255.0, green: 187/255.0, blue: 102/255.0, alpha: 1.0).set()
       
        UIRectFillUsingBlendMode(fillRect, .SourceIn)
    }
    
    
}
