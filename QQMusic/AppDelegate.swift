//
//  AppDelegate.swift
//  QQMusic
//
//  Created by 王蒙 on 15/8/27.
//  Copyright © 2015年 王蒙. All rights reserved.
//

import UIKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        //设置后台播放
        WMBackPalyTool.setupBackPlay()
        return true
    }



}

