//
//  LocaleConstants.swift
//
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

/**
ロケール定数クラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class LocaleConstants {
    
    /** クラスプロパティ構造体 */
    private struct ClassProperty {
        /** ロケール */
        static var locale = "ja_JP"
    }
    
    /** ロケール定数 */
    class var LOCALE: String {
        get {
            return ClassProperty.locale
        }
    }
}