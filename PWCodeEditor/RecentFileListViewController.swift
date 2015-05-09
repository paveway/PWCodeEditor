//
//  RecentFileListViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
最近使用したファイル一覧画面クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class RecentFileListViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    /** 画面タイトル */
    let kScreenTitle = "最近使用したファイル一覧"
    
    /** セル名 */
    let kCellName = "Cell"
    
    /** ツールバーボタン名配列 */
    let kToolbarButtonNames = ["クリアリスト"]
    
    /** ツールバーボタン名列挙子 */
    enum TooBarButtonName: NSInteger {
        case ClearList = 0
    }
    
    /** ファイル名リスト */
    var fileNameList: Array<String>?

    // MARK: - UIViewControllerDelegate

    /**
    インスタンスが生成された時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // 背景色を設定する。
        view.backgroundColor = UIColor.whiteColor()
        
        // 画面タイトルを設定する。
        navigationItem.title = kScreenTitle
        
        // ツールバーを設定する。
        setToolbar()
    }
 
    /**
    メモリ不足の時に呼び出される。
    */
    override func didReceiveMemoryWarning() {
        // スーパークラスのメソッドを呼び出す。
        super.didReceiveMemoryWarning()
    }
 
    /**
    画面が表示される前に呼び出される。

    :param: animated アニメーション指定
    */
    override func viewWillAppear(animated: Bool) {
        // ツールバーを表示する。
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillAppear(animated)
    }
    
    // MARK: - UITableViewDataSource
    
    /*
    セルの総数を返す。
    
    :param: tableView テーブルビュー
    :param: section セクション番号
    :return: セルの総数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /*
    セルを設定する。
    
    :param: tableView テーブルビュー
    :param: indexPath インデックスパス
    :return: セル
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // セルを取得する。
        var cell =
            tableView.dequeueReusableCellWithIdentifier(kCellName) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell()
        }
        
        // TODO: 未実装
        
        // セルを返却する。
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    /*
    セルが選択された際に呼び出される。
    
    :param: tableView テーブルビュー
    :param: indexPath インデックスパス
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 選択状態を解除する。
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Handler
    
    /**
    ツールバーボタンを押下した時の処理を行う。
    
    :param: sender ツールバーボタン
    */
    internal func toolbarButtonPressed(sender: UIButton) {
        // クリアリストボタンの場合
        if sender.tag == TooBarButtonName.ClearList.hashValue {
            // TODO:未実装
        
        } else {
            // 何もしない。
        }
    }
    
    // MARK: - Private Method
    
    /**
    ツールバーを設定する。
    */
    private func setToolbar() {
        // ツールバーのボタンを生成する。
        // クリアリストボタン
        var index = TooBarButtonName.ClearList.hashValue
        let clearListButton =
        UIBarButtonItem(title: kToolbarButtonNames[index],
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "toolbarButtonPressed:")
        clearListButton.tag = index
        
        // ボタン間のスペーサー
        let gap =
        UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,
            target: nil,
            action: nil)
        
        // ツールバーのボタンを設定する。
        let buttons: NSArray = [gap, clearListButton]
        toolbarItems = buttons as [AnyObject]
        
        // ツールバーを表示する。
        navigationController?.toolbarHidden = false
    }
}

    