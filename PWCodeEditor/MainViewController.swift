//
//  MainViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
メイン画面クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class MainViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    /** 画面タイトル */
    let kScreenTitle = "PWコードエディタ"
    
    /** ツールバーボタン名配列 */
    let kToolBarButtonNames = ["設定", "ヘルプ"]
    
    /** ツールバーボタン名列挙子 */
    enum TooBarButtonName: NSInteger {
        case Setting = 1
        case Help = 2
    }
    
    /** セル名 */
    let kCellName = "Cell"
    
    /** セクション数 */
    let kSectionNum = 1
    
    /** セル名配列 */
    let kCellNames = ["最近使用したファイル", "ローカルファイル", "Dropbox", "Github", "開発"]
    
    /** セル名列挙子 */
    enum CellName: NSInteger {
        case RecentFiles = 0
        case LocalFiles = 1
        case Dropbox = 2
        case Github = 3
        case Develop = 4
    }
    
    /** ルートディレクトリ名 */
    let kRootDirName = "PWCodeEditor"
    
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
    
    :param: path名 パス名
    */
    override init(style: UITableViewStyle) {
        // スーパークラスのイニシャライザを呼び出す。
        super.init(style: UITableViewStyle.Grouped)
    }
    
    // MARK: - UIViewControllerDelegate
    
    /**
    インスタンスが生成された時に呼び出される。
    */
    override func viewDidLoad() {
        // スーパークラスのメソッドを呼び出す。
        super.viewDidLoad()
            
        // 画面タイトルを設定する。
        self.navigationItem.title = kScreenTitle
                
        // ツールバーを設定する。
        setToolbar()
        
        // ルートディレクトリパスを取得する
        let rootDirPath = FileUtil.getDirPath(kRootDirName)
        
        // ルートディレクトリパスが存在しない場合
        if !FileUtil.fileExistsAtPath(rootDirPath) {
            // ルートディレクトリを作成する
            let error = NSErrorPointer()
            let result = FileUtil.createDir(rootDirPath, error: error)
        }
        
        // テーブルビューのスクロールを禁止する。
        tableView.scrollEnabled = false;
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
        // ツールバーを表示する。
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillAppear(animated)
    }
    
    // MARK: - UITableViewDataSource
    
    /*
    セルの総数を返す.
    
    :param: tableView テーブルビュー
    :param: section セクション番号
    :return: セルの総数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kCellNames.count
    }
    
    /*
    テーブルセルを設定する。
    
    :param: tableView テーブルビュー
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // セルを取得する。
        var cell =
            tableView.dequeueReusableCellWithIdentifier(kCellName) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell()
        }
        
        // セルにタイトルを設定する。
        cell?.textLabel!.text = kCellNames[indexPath.row];
        
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

        // 最近使用したファイル一覧の場合
        if indexPath.row == CellName.RecentFiles.hashValue {
            // 最近使用したファイル一覧画面に遷移する。
            let vc = RecentFileListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    
        // ローカルファイルの場合
        } else if indexPath.row == CellName.LocalFiles.hashValue {
            // ローカルファイル一覧画面に遷移する。
            let rootDirPath = FileUtil.getDirPath(kRootDirName)
            let vc = LocalFileListViewController(pathName: rootDirPath)
            self.navigationController?.pushViewController(vc, animated: true)
        
        // Dropboxの場合
        } else if indexPath.row == CellName.Dropbox.hashValue {
            // TODO: 未実装
            
        // Githubの場合
        } else if indexPath.row == CellName.Github.hashValue {
            // TODO: 未実装
        
        // 開発メニューの場合        
        } else if indexPath.row == CellName.Develop.hashValue {
            // TODO: 未実装
        }
    }
    
    // MARK: - Handler
    
    /**
    ツールバーボタンが押下された時に呼び出される。
    
    :param: sender 押下されたツールバーボタン
    */
    func toolbarButtonPressed(sender: UIBarButtonItem) {
        // ヘルプボタンの場合
        if sender.tag == TooBarButtonName.Help.hashValue {
            // ヘルプ画面に遷移する。
            let vc = HelpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        // 設定ボタンの場合
        } else if sender.tag == TooBarButtonName.Setting.hashValue {
            // 設定画面に遷移する。
            let vc = SettingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Private Method
    
    /**
    ツールバーを設定する。
    */
    private func setToolbar() {
        // ツールバーのボタンを生成する。
        // 設定ボタン
        var index = TooBarButtonName.Setting.hashValue
        let settingButton =
        UIBarButtonItem(title: kToolBarButtonNames[index],
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "toolbarButtonPressed:")
        settingButton.tag = index
        
        // ヘルプボタン
        index = TooBarButtonName.Help.hashValue
        let helpButton =
        UIBarButtonItem(title: kToolBarButtonNames[index],
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "toolbarButtonPressed:")
        helpButton.tag = index
        
        // ボタン間のスペーサー
        let gap =
        UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,
            target: nil,
            action: nil)
        
        // ツールバーのボタンを設定する。
        let buttons: NSArray = [settingButton, gap, helpButton]
        self.toolbarItems = buttons as [AnyObject]
        
        // ツールバーを表示する。
        self.navigationController?.toolbarHidden = false
    }
}

