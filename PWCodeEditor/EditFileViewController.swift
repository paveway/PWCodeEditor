//
//  EditFileViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
ファイル編集画面クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class EditFileViewController: UIViewController {

    /** ファイルパス名 */
    var filePathName = ""
    
    /** コンテンツ */
    var contents: UITextView?
    
    var extentionWindow: UIWindow?
    var extentionWindowKey: Void?
    var button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    // MARK: - Initializer
    
    /**
    イニシャライザ
    
    :param: coder デコーダー
    */
    required init(coder aDecoder: NSCoder) {
        // スーパークラスのイニシャライザを呼び出す。
        super.init(coder: aDecoder)
    }
    
    /**
    イニシャライザ
    
    :param: nibName NIB名
    :param: bundle バンドル
    */
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        // スーパークラスのイニシャライザを呼び出す。
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /**
    イニシャライザ
    
    :param: filePathName ファイルパス名
    */
    init(filePathName: String) {
        // スーパークラスのイニシャライザを呼び出す。
        super.init(nibName: nil, bundle: nil)

        // 引数のファイルパス名を保存する。
        self.filePathName = filePathName
    }

    // MARK: - UIViewController -
    
    /**
    インスタンスが生成された時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // 背景色を設定する。
        view.backgroundColor = UIColor.whiteColor()
        
        // 画面タイトルを設定する。
        let error: NSErrorPointer = nil
        navigationItem.title = FileUtil.getFileName(filePathName)
        
        // コンテンツを生成する。
        let frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        contents = UITextView(frame: frame)
        contents?.text = FileUtil.readFile(filePathName)
        view.addSubview(contents!)
/*
        var keyboard = UIView(frame: CGRectMake(0, 0, 320, 40))
        keyboard.backgroundColor = UIColor.grayColor()
        
        var button1 = UIButton(frame: CGRectMake(5, 5, 20, 30))
        button1.backgroundColor = UIColor.lightGrayColor()
        button1.setTitle("1", forState: UIControlState.Normal)
        keyboard.addSubview(button1)
        
        var button2 = UIButton(frame: CGRectMake(35, 5, 20, 30))
        button2.backgroundColor = UIColor.lightGrayColor()
        button2.setTitle("2", forState: UIControlState.Normal)
        keyboard.addSubview(button2)
        
        contents?.inputAccessoryView = keyboard
        contents?.inputAccessoryView?.reloadInputViews()
*/
        
/*
        var keyboard = UIView(frame: CGRectMake(0, 0, 320, 40))
        keyboard.backgroundColor = UIColor.darkGrayColor()
        
        var button = UIButton(frame: CGRectMake(5, 5, 80, 30))
        button.backgroundColor = UIColor.lightGrayColor()
        button.setTitle("Done", forState: UIControlState.Normal)
        button.addTarget(self, action: "onButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        keyboard.addSubview(button)
        
        contents?.addSubview(keyboard)
*/
    }
    
    internal func onButtonPressed(sender: UIButton) {
        
    }
    
    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        // スーパークラスのメソッドを呼び出す。
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        // スーパークラスのメソッドを呼び出す。
        super.viewDidAppear(animated)
    }
    
    /**
    画面が消去される前に呼び出される。

    :param: animated アニメーションの指定
    */
    override func viewWillDisappear(animated: Bool) {
        // コンテンツの内容をファイルに書き出す。
        FileUtil.writeFile(filePathName, data: contents!.text)

//        NSNotificationCenter.defaultCenter().removeObserver(self)

        // スーパークラスのメソッドを呼び出す。
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Handler
    func keyboardDidShow(notification: NSNotification) {
//        openExtentionWindow()
    }
    
    func keyboardDidHide(notification: NSNotification) {
//        closeExtentionWindow()
    }
    
    // MARK: - Private Method
    private func openExtentionWindow() {
        extentionWindow = UIWindow(frame: CGRect(x: 230, y: 621, width: 42, height: 42))
        extentionWindow?.windowLevel = UIWindowLevelNormal + 5
        extentionWindow?.makeKeyAndVisible()
        //let button = UIButton(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        extentionWindow?.addSubview(button)
        extentionWindow?.backgroundColor = UIColor.orangeColor()
        
        objc_setAssociatedObject(UIApplication.sharedApplication(), &extentionWindowKey, extentionWindow, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
    
    private func closeExtentionWindow() {
        objc_setAssociatedObject(UIApplication.sharedApplication(), &extentionWindowKey, nil, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        extentionWindow = nil
        
        UIApplication.sharedApplication().windows.first?.makeKeyAndVisible()
    }
}
    