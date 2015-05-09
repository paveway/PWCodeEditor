//
//  AppDelegate.swift
//  PWCodeEditor
//
//  Created by Masatsugu Futamata on 2015/05/09.
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import UIKit

/**
PWコードエディタ
アプリケーションデリゲートクラス

:version: 1.0 新規作成
*/
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /** ウィンドウオブジェクト */
    var window: UIWindow?

    /**
    起動後に呼び出される。
    
    :param: launchOptions 起動オプション
    :return: 処理結果
    */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // ビューコントローラを生成する。
        let vc = MainViewController(style: UITableViewStyle.Grouped)
        
        // ナビゲーションコントローラを生成する。
        let nc = UINavigationController(rootViewController: vc)
        
        // ウィンドウを生成する。
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // ウィンドウのルートビューコントローラを設定する。
        self.window?.rootViewController = nc
        
        // ウィンドウを表示する。
        self.window?.makeKeyAndVisible()
        
        // 処理結果正常を返却する。
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

