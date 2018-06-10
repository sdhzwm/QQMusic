//
//  WMLrcView.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/28.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit

class WMLrcView: UIScrollView {
    private var tableView: UITableView!
    /// 歌词的数据
    private var lrcList = [WMLrcLine]()
    /// 当前歌曲的下标
    private var currIndex = 0
    /// 外面歌词的label
    var lrcLabel = WMLrcLabel()
    /// 当前歌曲的总时长
    var duration: TimeInterval = 0
    
    /// 当前歌曲的歌词名称
    var lrcName:String? {
        didSet {
            if let lrcText = lrcName {
                currIndex = 0
                lrcList = WMLrcTool.lrc(with: lrcText)
                tableView.reloadData()
            }
        }
    }
    /// 当前播放的时间
    var currentTime:TimeInterval = 0 {
        
        didSet {
            //如果当歌曲刚开始的时候让其滚动到中间
            if currentTime == 0 {
                scrollToCurrentCell()
            }
            
            //当前时间和歌词进行匹配
            let count = lrcList.count
            for i in 0...count-1 {
                let currentLine = lrcList[i]
                //获取下一句话的歌词
                let nextIndex = i + 1
                var nextLine:WMLrcLine?
                if nextIndex < count {
                    nextLine = lrcList[nextIndex]
                }
                if currIndex != i && currentTime >= currentLine.time && currentTime < nextLine?.time ?? 0 {
                    //获取需要刷新的行号
                    let indexPath = IndexPath(row: i, section: 0)
                    let previousIndexPath = IndexPath(row: currIndex, section: 0)
                    currIndex = i
                    //刷新当前和上一行
                    tableView.reloadRows(at: [indexPath, previousIndexPath], with: .none)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    lrcLabel.text = currentLine.text
                    //生成锁屏的图片
                    setupBackPlayImage()
                }
                
                //根据进度,显示label画多少
                if currIndex == i {
                    let indexPath = IndexPath(row: i, section: 0)
                    let cell = tableView.cellForRow(at: indexPath) as? WMLrcCell
                    
                    let progress = (currentTime - currentLine.time) / ((nextLine?.time)! - currentLine.time)
                    cell?.lrcLabel.progress = CGFloat(progress)
                    
                    // 设置外面歌词的Label的进度
                    lrcLabel.progress = CGFloat(progress)
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
    
}
//MARK: 抽离didSet中得方法
extension WMLrcView {
    ///设置背景图片
    private func setupBackPlayImage() {
        //获取到当前播放歌曲的图片
        let playingMusic = WMMusicTool.shared.playerMusic()
        let currentImage = UIImage(named: playingMusic.icon!)
        //获取到当前歌词以及前一句和后一句歌词
        let currLrc = lrcList[currIndex]
        //上一句
        let previousIndex = currIndex - 1
        var prevousLrc: WMLrcLine?
        if previousIndex >= 0 {
            prevousLrc = lrcList[previousIndex]
        }
        
        //下一句歌词
        let nextIndex = currIndex + 1
        var nextLrc:  WMLrcLine?
        
        if nextIndex < lrcList.count {
            nextLrc = lrcList[nextIndex]
        }
        //获取到返回的图片
        let lockImage = currentImage?.setImage(titleH: 25.0, currText: currLrc.text, prevousText: prevousLrc?.text, nextText: nextLrc?.text)
        //设置锁屏以及后台播放的信息
        WMBackPalyTool.setupLockScreenInfo(with: lockImage!, duration: duration, currTime: currentTime)
        
    }
}
//MARK: tableView的代理
extension WMLrcView: UITableViewDataSource {
    //cell的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcList.count
    }
    
    //设置cell的内容的展示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WMLrcCell.lrcCell(with: tableView)
        //如果是当前行的话，字体变大
        if (indexPath.row == currIndex) {
            cell.lrcLabel?.font = UIFont.systemFont(ofSize: 16)
        } else {
            cell.lrcLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.lrcLabel?.progress = 0
        }
        let lrcline = lrcList[indexPath.row]
        cell.lrcLabel?.text = lrcline.text
        return cell
    }
}
//MARK: 一些初始化设置
extension WMLrcView {
    
    private func settingTableView() {
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 35
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let lrcViewVVFL = "V:|-0-[lrcView(==hScrollView)]-0-|";
        
        let lrcViewVCons = NSLayoutConstraint.constraints(withVisualFormat: lrcViewVVFL, options: .directionLeadingToTrailing, metrics: nil, views: ["lrcView" : tableView,"hScrollView" : self])
        
        addConstraints(lrcViewVCons)
        
        let lrcViewWidthCon = NSLayoutConstraint(item: tableView, attribute: .width, relatedBy:.equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
        
        let lrcViewRightCon = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
        let lrcViewLeftCon = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: self.bounds.width)
        
        addConstraint(lrcViewLeftCon)
        addConstraint(lrcViewRightCon)
        addConstraint(lrcViewWidthCon)
        
        tableView.contentInset = UIEdgeInsetsMake(bounds.height * 0.5, 0, bounds.height * 0.5, 0);
        scrollToCurrentCell()
    }

    
    private func scrollToCurrentCell() {
        let indexPath = IndexPath(row: currIndex, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
}
