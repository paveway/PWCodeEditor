//
//  Dialog.swift
//
//  Copyright (c) 2015年 pavway.info. All rights reserved.
//

import UIKit

/**
ダイアログクラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class Dialog {
    
    /**
    ダイアログを生成する。

    :param: title タイトル
    :param: message メッセージ
    :param: handler ハンドラ
    :return: ダイアログ
    */
    class func createDialog(title: String, message: String, handler: ((UIAlertAction!) -> Void)!) -> UIAlertController {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: handler)
        dialog.addAction(okAction)
        return dialog
    }
}
