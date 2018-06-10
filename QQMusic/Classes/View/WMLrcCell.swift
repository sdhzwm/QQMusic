//
//  WMLrcCellTableViewCell.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcCell: UITableViewCell {
    
    static let reuseId = "LrcCell"
    
    var lrcLabel:WMLrcLabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lrcLabel = WMLrcLabel()
        lrcLabel.textColor = UIColor.white
        lrcLabel.font = UIFont.systemFont(ofSize: 14)
        lrcLabel.textAlignment = .center
        contentView.addSubview(lrcLabel)
        lrcLabel.translatesAutoresizingMaskIntoConstraints = false
        
         let labelHCon = NSLayoutConstraint(item: lrcLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
         let labelVCon = NSLayoutConstraint(item: lrcLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        addConstraint(labelHCon)
        addConstraint(labelVCon)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func lrcCell(with tableView:UITableView) ->WMLrcCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId) as? WMLrcCell
        if (cell == nil) {
            cell = WMLrcCell(style: .default, reuseIdentifier: reuseId)
            cell!.backgroundColor = UIColor.clear
            cell!.selectionStyle = .none
        
        }
        return cell!
    }
}
