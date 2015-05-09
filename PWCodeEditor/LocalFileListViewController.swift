//
//  LocalFileListViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
ローカルファイル一覧画面クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class LocalFileListViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    /** セル名 */
    let kCellName = "Cell"
    
    /** ツールバーボタン名配列 */
    let kToolBarButtonNames = ["＋", "設定", "ヘルプ"]
    
    /** ツールバーボタン名列挙子 */
    enum TooBarButtonName: NSInteger {
        case Add = 0
        case Setting = 1
        case Help = 2
    }
    
    /** パス名 */
    var pathName = ""
    
    /** ファイル名リスト */
    var fileNameList: Array<String>?
    
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
    init(pathName: String) {
        Log.d("pathName=\(pathName)")
        
        // スーパークラスのイニシャライザを呼び出す。
        super.init(style: UITableViewStyle.Plain)
        
        // 引数のパス名を保存する。
        self.pathName = pathName
    }
    
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
        navigationItem.title = FileUtil.getFileName(pathName)
        
        // 右上に編集ボタンを設定する。
        navigationItem.rightBarButtonItem = editButtonItem()
        
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
        // ツールバーを表示する。
        navigationController?.setToolbarHidden(false, animated: true)
        
        // ファイル名リストを取得する
        let error: NSErrorPointer = nil
        fileNameList = FileUtil.getFileNameList(pathName, error: error)
        // エラーの場合
        if error != nil {
            // エラーダイアログを表示する。
            let errorDialog = Dialog.createDialog("エラー", message: "ファイル名リストが取得できません。", handler: nil)
            presentViewController(errorDialog, animated: true, completion: {
                // 元の画面に戻る。
                navigationController?.popViewControllerAnimated(true)
            })
        }
        
        // ファイルがない場合
        if fileNameList?.count == 0 {
            // Editボタンを無効にする。
            navigationItem.rightBarButtonItem?.enabled = false;
            
            // ファイルがある場合
        } else {
            // Editボタンを有効にする。
            navigationItem.rightBarButtonItem?.enabled = true;
        }
        
        // テーブルビューをリロードする。
        tableView.reloadData()
        
        // スーパークラスのメソッドを呼び出す。
        super.viewWillAppear(animated)
    }
    
    // MARK: - UITableViewDataSource
    
    /**
    セルの総数を返す。
    
    :param: tableView テーブルビュー
    :param: section セクション番号
    :return: セルの総数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ファイル名リスト数を返却する。
        return fileNameList!.count
    }
    
    /*
    セルを設定する。
    
    :param: tableView テーブルビュー
    :param: indexPath インデックスパス
    :return: セル
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得する.
        var cell =
            tableView.dequeueReusableCellWithIdentifier(kCellName) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell()
        }
        
        // セルに値を設定する.
        // ファイル名を取得する。
        let fileName = fileNameList?[indexPath.row]
        Log.d("fileName=\(fileName)")
        
        // セルの表示名にファイル名を設定する。
        cell?.textLabel!.text = fileName
        
        // ファイルタイプを取得する。
        let filePath = pathName.stringByAppendingPathComponent(fileName!)
        let fileType = FileUtil.isFileOrDirectory(filePath)
        
        // ファイルタイプ別に処理を判別する。
        switch fileType {
        // ディレクトリの場合
        case FileType.Directory:
            // セルにディスクロージャーインディケーターを表示する。
            cell?.accessoryType = .DisclosureIndicator
            break
            
        // ファイルの場合
        case FileType.File:
            // 何もしない。
            break
            
        // 上記以外
        default:
            // 何もしない。
            break
        }
        
        // セルを返却する。
        return cell!
    }
    
    /**
    編集モードの編集/削除時に呼び出される。

    :param: tableView テーブルビュー
    :param: editingStyle 編集スタイル
    :param: indexPath インデックスパス
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 削除の場合
        if UITableViewCellEditingStyle.Delete == editingStyle {
            // ファイル名を取得する。
            let fileName = fileNameList?[indexPath.row]
            
            // ファイルパス名に変換する。
            let filePathName = pathName.stringByAppendingPathComponent(fileName!)
            
            // ファイルパス名のファイルを削除する。
            let error: NSErrorPointer = nil
            let result = FileUtil.deleteFile(filePathName, error: error)
            
            // ファイルが削除できた場合
            if !result || error == nil {
                // ファイルリストとテーブルビューを更新する。
                fileNameList?.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                // ファイルがない場合
                if fileNameList?.count == 0 {
                    // Editボタンに変更する。
                    setEditing(false, animated: true)
                    
                    // Editボタンを無効にする。
                    navigationItem.rightBarButtonItem?.enabled = false;
                
                // ファイルがある場合
                } else {
                    // Editボタンを有効にする。
                    navigationItem.rightBarButtonItem?.enabled = true;
                }
            
            // ファイルが削除できない場合
            } else {
                // エラーダイアログを表示する。
                let errorDialog = Dialog.createDialog("エラー", message: "ファイルが削除できません。", handler: nil)
                presentViewController(errorDialog, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    
    /**
    セルが選択された際に呼び出される.
    
    :param: tableView テーブルビュー
    :param: indexPath インデックスパス
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 選択状態を解除する。
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // ファイル名を取得する。
        let fileName = fileNameList?[indexPath.row]
        
        // ファイルタイプを取得する。
        let filePathName = pathName.stringByAppendingPathComponent(fileName!)
        let fileType = FileUtil.isFileOrDirectory(filePathName)
        
        // ファイルタイプがディレクトリの場合
        if fileType == FileType.Directory {
            // ローカルファイルリスト画面に遷移する。
            let vc = LocalFileListViewController(pathName: filePathName)
            navigationController?.pushViewController(vc, animated: true)
        
        // ファイルタイプがファイルの場合
        } else if fileType == FileType.File {
            // ファイル編集画面に遷移する。
            let vc = EditFileViewController(filePathName: filePathName)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Handler
    
    /**
    ツールバーボタンを押下した時の処理

    :param: sender ツールバーボタン
    */
    func toolbarButtonPressed(sender: UIBarButtonItem) {
        // 追加ツールボタンの場合
        if sender.tag == TooBarButtonName.Add.hashValue {
            // ファイル生成画面に遷移する。
            let vc = CreateFileViewController(pathName: pathName)
            navigationController?.pushViewController(vc, animated: true)
            
        // 設定ツールボタンの場合
        } else if sender.tag == TooBarButtonName.Setting.hashValue {
            // 設定画面に遷移する。
            let vc = SettingViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        // ヘルプツールボタンの場合
        } else if sender.tag == TooBarButtonName.Help.hashValue {
            // ヘルプ画面に遷移する。
            let vc = HelpViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        // 上記以外
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
        // ＋ボタン
        var index = TooBarButtonName.Add.hashValue
        let addButton =
        UIBarButtonItem(title: kToolBarButtonNames[index],
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "toolbarButtonPressed:")
        addButton.tag = index
        
        // 設定ボタン
        index = TooBarButtonName.Setting.hashValue
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
        let buttons: NSArray = [addButton, gap, settingButton, gap, helpButton]
        toolbarItems = buttons as [AnyObject]
        
        // ツールバーを表示する。
        navigationController?.toolbarHidden = false
    }
}

