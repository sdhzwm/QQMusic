//
//  WMLrcView.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcView: UIScrollView {
    private var _tableView = UITableView()
    /// 歌词的数据
    private var lrcList = NSArray()
    /// 当前歌曲的下标
    private var currIndex:Int?
    /// 外面歌词的label
    var lrcLabel = WMLrcLabel()
    /// 当前歌曲的总时长
    var duration:NSTimeInterval?
    
    /// 当前歌曲的歌词名称
    var lrcName:String? {
        didSet {
            if let lrcText = lrcName {
                currIndex = 0
                lrcName = lrcText
                lrcList = WMLrcTool.lrcToolWithLrcName(lrcName!)
                _tableView.reloadData()
            }
        }
    }
    /// 当前播放的时间
    var currentTime:NSTimeInterval? {
        
        didSet {
            if let currTimer = currentTime {
                //如果当歌曲刚开始的时候让其滚动到中间
                if currentTime == 0 {
                    tableViewToScrillViewIndexPath()
                }
                currentTime = currTimer
                //当前时间和歌词进行匹配
                let count = lrcList.count
                for i in 0...count-1 {
                    let currentLine = lrcList[i] as! WMLrcLine
                    //获取下一句话的歌词
                    let nextIndex = i + 1
                    var nextLine:WMLrcLine?
                    if nextIndex < count {
                        nextLine = lrcList[nextIndex] as? WMLrcLine
                    }
                    if currIndex != i && currentTime >= currentLine.lrcTime && currentTime < nextLine?.lrcTime {
                        //获取需要刷新的行号
                        let indexPath = NSIndexPath(forRow: i, inSection: 0)
                        let previousIndexPath = NSIndexPath(forRow: currIndex!, inSection: 0)
                        currIndex = i
                        //刷新当前和上一行
                        _tableView.reloadRowsAtIndexPaths([indexPath,previousIndexPath], withRowAnimation: .None)
                        _tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                        lrcLabel.text = currentLine.lrcText
                        //生成锁屏的图片
                        setupBackPlayImage()
                    }
                    
                    //根据进度,显示label画多少
                    if currIndex == i {
                        let indexPath = NSIndexPath(forRow: i, inSection: 0)
                        let cell = _tableView.cellForRowAtIndexPath(indexPath) as? WMLrcCell
                
                        let progress = (currentTime! - currentLine.lrcTime!) / ((nextLine?.lrcTime)! - currentLine.lrcTime!)
                        cell?._lrcLabel?.progress = CGFloat(progress)
                        
                        // 设置外面歌词的Label的进度
                        lrcLabel.progress = CGFloat(progress)
                    }

                }
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        settingTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingTableView()
    }
    override func awakeFromNib() {
        settingTableView()
    }
}
//MARK: 抽离didSet中得方法
extension WMLrcView {
    ///设置背景图片
    private func setupBackPlayImage() {
        //获取到当前播放歌曲的图片
        let playingMusic = WMMusicTool.playerMusic()
        let currentImage = UIImage(named: playingMusic.icon!)
        //获取到当前歌词以及前一句和后一句歌词
        let currLrc = lrcList[currIndex!] as! WMLrcLine
        //上一句
        let previousIndex = currIndex! - 1
        var prevousLrc: WMLrcLine?
        if previousIndex >= 0 {
            prevousLrc = lrcList[previousIndex] as? WMLrcLine
        }
        
        //下一句歌词
        let nextIndex = currIndex! + 1
        var nextLrc = WMLrcLine()
        
        if nextIndex < lrcList.count {
            nextLrc = lrcList[nextIndex] as! WMLrcLine
        }
        //获取到返回的图片
        let lockImage = currentImage?.setImageWithString(25.0, currText: currLrc.lrcText!, prevousText: prevousLrc?.lrcText, nextText: nextLrc.lrcText)
        //设置锁屏以及后台播放的信息
        WMBackPalyTool.setupLockScreenInfoWithLockImage(lockImage!, duration: duration!, currTime: currentTime!)

    }
}
//MARK: tableView的代理
extension WMLrcView: UITableViewDataSource {
    //cell的数量
   @objc internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcList.count
    }
    //设置cell的内容的展示
   @objc internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = WMLrcCell.lrcCellWithTableView(tableView)
        //如果是当前行的话，字体变大
        if (currIndex == indexPath.row) {
            cell._lrcLabel?.font = UIFont.systemFontOfSize(16)
        } else {
            cell._lrcLabel?.font = UIFont.systemFontOfSize(14)
            cell._lrcLabel?.progress = 0
        }
       let lrcline = lrcList[indexPath.row] as! WMLrcLine
        cell._lrcLabel?.text = lrcline.lrcText
        return cell;
    }
}
//MARK: 一些初始化设置
extension WMLrcView {
    
   private func settingTableView(){
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
        tableView.rowHeight = 35
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
       
        _tableView = tableView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let lrcViewVVFL = "V:|-0-[lrcView(==hScrollView)]-0-|";
        
        let lrcViewVCons = NSLayoutConstraint.constraintsWithVisualFormat(lrcViewVVFL, options: .DirectionLeadingToTrailing, metrics: nil, views: ["lrcView" : _tableView,"hScrollView" : self])
        
        addConstraints(lrcViewVCons)
        
        let lrcViewWidthCon = NSLayoutConstraint(item: _tableView, attribute: .Width, relatedBy:.Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: 0)
        
        let lrcViewRightCon = NSLayoutConstraint(item: _tableView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0)
        let lrcViewLeftCon = NSLayoutConstraint(item: _tableView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: self.bounds.width)
        
        addConstraint(lrcViewLeftCon)
        addConstraint(lrcViewRightCon)
        addConstraint(lrcViewWidthCon)
        
        _tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
        tableViewToScrillViewIndexPath()
    }
    
    private func tableViewToScrillViewIndexPath() {
        let indexPath = NSIndexPath(forRow: currIndex!, inSection: 0)
        _tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
    }

}
