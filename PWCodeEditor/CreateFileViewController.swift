//
//  CreateFileViewController.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
ファイル生成画面クラス

:param: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class CreateFileViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    /** 画面タイトル */
    let kScreenTitle = "新規作成"
    
    /** セル名 */
    let kCellName = "Cell"
    
    /** セクションタイトル配列 */
    let kSectionTitles: NSArray = ["ファイルタイプ", "ファイル項目"]
    
    /** ファイルタイプタイトル配列 */
    let kFileTypeTitles: NSArray = ["ファイル", "ディレクトリ"]
    
    /** ファイル項目タイトル配列配列 */
    let kFileItemTitles: NSArray = ["ファイル名", "文字エンコーディング", "改行コード"]
    
    /** セクションタイトルインデックス */
    enum SectionIndex: NSInteger {
        /** ファイルタイプ */
        case FileType = 0
        
        /** ファイル項目 */
        case FileItem = 1
    }
    
    /** ファイルタイプインデックス */
    enum FileTypeIndex: NSInteger {
        /** ファイル */
        case File = 0
        
        /** ディレクトリ */
        case Directory = 1
    }
    
    /** ファイル項目インデックス */
    enum FileItemIndex: NSInteger {
        /** ファイル名 */
        case FileName = 0
        
        /** 文字エンコーディング */
        case CharEncoding = 1
        
        /** 改行コード */
        case LineEndingCode = 2
    }
    
    /** ファイル名入力値左マージン */
    let kFileNameValueLeftMargin: CGFloat = 100.0
    
    /** ファイル名入力値右マージン */
    let kFileNameValueRightMargin: CGFloat = 7.0
    
    /** ファイル名入力値上マージン */
    let kFileNameValueTopMargin: CGFloat = 7.0
    
    /** ファイル名入力値下マージン */
    let kFileNameValueBottomMargin: CGFloat = 7.0 * 2
    
    /** パス名 */
    var pathName: String?
    
    /** ファイル名入力値 */
    var fileNameValue: UITextField?
    
    /** 画面タップジェスチャー */
    var screenTap: UITapGestureRecognizer?
    
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
    
    :param: pathName パス名
    */
    init(pathName: String) {
        // スーパークラスのイニシャライザを呼び出す。
        super.init(style: UITableViewStyle.Grouped)
        
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
        navigationItem.title = kScreenTitle
        
        // 左上ボタンにCancelボタンを設定する。
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "onCancelButtonPressed:")
        
        // 右上ボタンにDoneボタンを設定する。
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "onDoneButtonPressed:")
        
        // テーブルビューのスクロールを禁止する。
        tableView.scrollEnabled = false
        
        // 単一選択とする。
        tableView.allowsMultipleSelection = false
        
        // 画面タップジェスチャーを設定する。
        screenTap = UITapGestureRecognizer(target: self, action: "onScreenTapped:")
        screenTap?.delegate = self
        screenTap?.numberOfTapsRequired = 1
        //view.addGestureRecognizer(screenTap!)
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
    
    // MARK: - UITableViewDataSource
    
    /*
    セクションの数を返す。
    
    :param: tableView テーブルビュー
    :return: セクション数
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return kSectionTitles.count
    }
    
    /*
    セクションのタイトルを返す。
    
    :param: tableView テーブルビュー
    :param section セクション番号
    :return: セクションのタイトル
    */
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return kSectionTitles[section] as? String
    }

    /*
    セルの総数を返す。
    
    :param: tableView テーブルビュー
    :param: section セクション番号
    :return: セルの総数
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セクション番号がファイルタイプの場合
        if section == SectionIndex.FileType.hashValue {
            return kFileTypeTitles.count
        
        // セクション番号がファイル項目の場合
        } else {
            return kFileItemTitles.count
        }
    }

    // MARK: - UITableViewDelegate
    
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
        
        // セクション番号がファイルタイプの場合
        if indexPath.section == SectionIndex.FileType.hashValue {
            // セルのタイトルにファイルタイプ名を設定する。
            cell?.textLabel!.text = kFileTypeTitles[indexPath.row] as? String
            if indexPath.row == 0 {
                cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell?.accessoryType = UITableViewCellAccessoryType.None
            }
        
        // セクション番号がファイル項目の場合
        } else {
            // セルのタイトルにファイル項目名を設定する。
            cell?.textLabel!.text = kFileItemTitles[indexPath.row] as? String
            
            // ファイル名項目の場合
            if indexPath.row == FileItemIndex.FileName.hashValue {
                // ファイル名入力用テキストフィールドを生成し、設定する。
                let frame = CGRectMake(kFileNameValueLeftMargin,
                                       kFileNameValueTopMargin,
                                       cell!.frame.width - kFileNameValueLeftMargin - kFileNameValueRightMargin,
                                       cell!.frame.height - kFileNameValueBottomMargin)
                fileNameValue = UITextField(frame: frame)
                fileNameValue!.autocapitalizationType = UITextAutocapitalizationType.None
                fileNameValue!.clearButtonMode = UITextFieldViewMode.WhileEditing
                fileNameValue!.borderStyle = UITextBorderStyle.RoundedRect
                fileNameValue!.keyboardType = UIKeyboardType.ASCIICapable
                fileNameValue!.returnKeyType = UIReturnKeyType.Done
                fileNameValue!.delegate = self
                cell?.contentView.addSubview(fileNameValue!)
                
            // セル行番号が文字エンコーディングまたは改行コードの場合
            } else if indexPath.row == FileItemIndex.CharEncoding.hashValue ||
                      indexPath.row == FileItemIndex.LineEndingCode.hashValue {
                // セルにディスクロージャーインディケーターを表示する。
                cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
        }
        
        // セルを返却する。
        return cell!
    }
    
    /**
    セルが選択された際に呼び出される.
    
    :param: tableView テーブルビュー
    :param: indexPath インデックスパス
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 選択状態を解除する。
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // セクションがファイルタイプの場合
        if indexPath.section == SectionIndex.FileType.hashValue {
            // ファイルセルを取得する。
            let fileIndexPath = NSIndexPath(forRow: FileTypeIndex.File.hashValue, inSection: SectionIndex.FileType.hashValue)
            let fileCell = tableView.cellForRowAtIndexPath(fileIndexPath)
            
            // ディレクトリセルを取得する。
            let directoryIndexPath = NSIndexPath(forRow: FileTypeIndex.Directory.hashValue, inSection: SectionIndex.FileType.hashValue)
            let directoryCell = tableView.cellForRowAtIndexPath(directoryIndexPath)

            // 文字エンコーディングセルを取得する。
            let charEncodingIndexPath = NSIndexPath(forRow: FileItemIndex.CharEncoding.hashValue, inSection: SectionIndex.FileItem.hashValue)
            let charEncodingCell = tableView.cellForRowAtIndexPath(charEncodingIndexPath)
            
            // 改行コードセルを取得する。
            let lineEndingCodeIndexPath = NSIndexPath(forRow: FileItemIndex.LineEndingCode.hashValue, inSection: SectionIndex.FileItem.hashValue)
            let lineEndingCodeCell = tableView.cellForRowAtIndexPath(lineEndingCodeIndexPath)
            
            // ファイルタイプがファイルの場合
            if indexPath.row == FileTypeIndex.File.hashValue {
                // ファイルセルにチェックをつける。
                fileCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                directoryCell?.accessoryType = UITableViewCellAccessoryType.None
                
                // 文字エンコーディングセルと改行コードセルを表示にする。
                charEncodingCell?.hidden = false
                lineEndingCodeCell?.hidden = false
        
            // ファイルタイプがディレクトリの場合
            } else {
                // ディレクトリセルにチェックをつける。
                fileCell?.accessoryType = UITableViewCellAccessoryType.None
                directoryCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                
                // 文字エンコーディングセルと改行コードセルを非表示にする。
                charEncodingCell?.hidden = true
                lineEndingCodeCell?.hidden = true
            }
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate

    /**
    リターンが押下された時の処理

    :param: textField テキストフィールド
    :return: 処理結果 true:正常終了 / false:異常終了
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // キーボードを閉じる。
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Handler
    
    /**
    Cancelボタンを押下した時に呼び出される。
    
    :param: sender Cancelボタン
    */
    internal func onCancelButtonPressed(sender: UIButton) {
        // 元の画面に戻る。
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
    Doneボタンを押下した時に呼び出される。
    
    :param: sender Doneボタン
    */
    internal func onDoneButtonPressed(sender: UIButton) {
        // キーボードを閉じる。
        fileNameValue?.resignFirstResponder()
        
        // ファイル名を取得する。
        let fileNameString = fileNameValue!.text
        
        // ファイル名が取得できた場合
        if (!fileNameString.isEmpty) {
            // ファイルセルを取得する。
            let fileIndexPath = NSIndexPath(forRow: FileTypeIndex.File.hashValue, inSection: SectionIndex.FileType.hashValue)
            let fileCell = tableView.cellForRowAtIndexPath(fileIndexPath)

            // ファイルパス名を取得する。
            let filePathName = pathName?.stringByAppendingPathComponent(fileNameString!)

            // ファイルが存在しない場合
            if !FileUtil.fileExistsAtPath(filePathName!) {
                // ファイルタイプにチェックがついている場合
                if fileCell?.accessoryType.hashValue == UITableViewCellAccessoryType.Checkmark.hashValue {
                    // ファイルを生成する。
                    let error: NSErrorPointer = nil
                    let result = FileUtil.createFile(filePathName!, error: error)
                    // 成功した場合
                    if result && error == nil {
                        // 元の画面に遷移する。
                        navigationController?.popViewControllerAnimated(true)
                        
                        // 失敗した場合
                    } else {
                        // エラーダイアログを表示する。
                        let errorDialog = Dialog.createDialog("エラー", message: "ファイルが生成できません。", handler: nil)
                        presentViewController(errorDialog, animated: true, completion: nil)
                    }
                    
                } else {
                    // ディレクトリを生成する。
                    let error: NSErrorPointer = nil
                    let result = FileUtil.createDir(filePathName!, error: error)
                    // 成功した場合
                    if result && error == nil {
                        // 元の画面に遷移する。
                        navigationController?.popViewControllerAnimated(true)
                        
                        // 失敗した場合
                    } else {
                        // エラーダイアログを表示する。
                        let errorDialog = Dialog.createDialog("エラー", message: "ディレクトリが生成できません。", handler: nil)
                        presentViewController(errorDialog, animated: true, completion: nil)
                    }
                }
            
            // ファイルが存在する場合
            } else {
                // エラーダイアログを表示する。
                let errorDialog = Dialog.createDialog("注意", message: "すでにファイルまたはディレクトリが存在しています。", handler: nil)
                presentViewController(errorDialog, animated: true, completion: nil)
            }
            
        // ファイル名が未入力の場合
        } else {
            // エラーダイアログを表示する。
            let errorDialog = Dialog.createDialog("注意", message: "ファイル名またはディレクトリ名を入力してください。", handler: nil)
            presentViewController(errorDialog, animated: true, completion: nil)
        }
    }
    
    /**
    画面をタップした時に呼び出される。

    :param: recognizer リコグナイザー
    */
    internal func onScreenTapped(recognizer: UITapGestureRecognizer) {
        // キーボードを閉じる。
        fileNameValue?.resignFirstResponder()
    }
}