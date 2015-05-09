//
//  SettingViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
設定画面クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class SettingViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    /** 画面タイトル */
    let kScreenTitle = "設定"

    /** セル名 */
    let kCellName = "Cell"

    // MARK: - UIViewControllerDelegate
    
    /**
    インスタンスが生成された時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // 背景色を設定する。
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 画面タイトルを設定する。
        self.navigationItem.title = kScreenTitle
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
    
    :param: animated アニメーションの指定
    */
    override func viewWillAppear(animated: Bool) {
        // ツールバーを表示しない。
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillAppear(animated)
    }
    
    // MARK: - UITableViewDataSource
    
    /*
    Cellの総数を返す.
    
    :param: tableView テーブルビュー
    :param: section セクション番号
    :return: セルの総数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /*
    セルに値を設定する.
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // セルを取得する.
        var cell =
            tableView.dequeueReusableCellWithIdentifier(kCellName) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell()
        }
        
        // セルを返却する。
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    /*
    Cellが選択された際に呼び出される.
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 選択状態を解除する。
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
