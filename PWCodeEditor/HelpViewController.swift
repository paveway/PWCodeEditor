//
//  HelpViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
ヘルプ画面クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class HelpViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    // 画面タイトル
    let kScreenTitle = "ヘルプ"
    
    // セル名
    let kCellName = "Cell"
    
    // MARK: - UIViewControllerDelegate
    
    /**
    インスタンスが生成され時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
        
        // 背景色を設定する。
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 画面タイトルを設定する。
        self.navigationItem.title = kScreenTitle
        
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
    
    :param: animated アニメーションの指定
    */
    override func viewWillAppear(animated: Bool) {
        // ツールバーを表示しない。
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Method
    
    private func setToolbar() {
        // TODO: 未実装
    }
}