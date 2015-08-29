//
//  WMLrcCellTableViewCell.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcCell: UITableViewCell {
    
    var _lrcLabel:WMLrcLabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let lrcLabel = WMLrcLabel()
        lrcLabel.textColor = UIColor.whiteColor()
        lrcLabel.font = UIFont.systemFontOfSize(14)
        lrcLabel.textAlignment = .Center
        contentView.addSubview(lrcLabel)
        _lrcLabel = lrcLabel
        lrcLabel.translatesAutoresizingMaskIntoConstraints = false
        
         let labelHCon = NSLayoutConstraint(item: lrcLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)
         let labelVCon = NSLayoutConstraint(item: lrcLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)
        addConstraint(labelHCon)
        addConstraint(labelVCon)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func lrcCellWithTableView(tableView:UITableView) ->WMLrcCell{
        let ID = "LrcCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? WMLrcCell
        if (cell == nil) {
            cell = WMLrcCell(style: .Default, reuseIdentifier: ID)
            cell!.backgroundColor = UIColor.clearColor()
            cell!.selectionStyle = .None
        
        }
        return cell!;
    }
}
