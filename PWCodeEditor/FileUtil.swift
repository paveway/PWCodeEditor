//
//  FileUtil.swift
//
//  Copyright (c) 2015年 Paveway. All rights reserved.
//

import Foundation

/** ファイルタイプ列挙子 */
enum FileType {
    case Invalid
    case Directory
    case File
}

/** ファイル情報構造体 */
struct FileInfo {
    /** ファイル名 */
    var fileName: NSString
    
    /** ファイルタイプ */
    var fileType: FileType
}

/**
ファイルユーティリティクラス

:version: 1.0 新規作成
:author: paveway.info@gmail.com
*/
class FileUtil {
 
    /**
    ルートパスを取得する。
    
    :return: ルートパス
    */
    class func getRootPath() -> String {
        let paths =
            NSSearchPathForDirectoriesInDomains(
                .DocumentDirectory,
                .UserDomainMask,
                true)
        return paths[0] as! String
    }

    /**
    ディレクトリパスを取得する。
    
    :param: dirName ディレクトリ名
    :return: ディレクトリパス
    */
    class func getDirPath(dirName: String) -> String {
        if dirName.isEmpty {
            return dirName
        }
        
        let rootPath = getRootPath()
        return rootPath.stringByAppendingPathComponent(dirName)
    }

    /**
    ファイルが存在するかチェックする。
    
    :param: filePathName ファイルパス名
    :return: チェック結果 true:存在する / false:存在しない
    */
    class func fileExistsAtPath(filePathName: String) -> Bool {
        if filePathName.isEmpty {
            return false
        }
        
        let fileManager = NSFileManager.defaultManager()
        return fileManager.fileExistsAtPath(filePathName)
    }
    
    /**
    ディレクトリを作成する。
    
    :param: dirPathName ディレクトリパス
    :return: 作成結果 true:成功 / false:失敗
    */
    class func createDir(dirPathName: String, error: NSErrorPointer) -> Bool {
        if dirPathName.isEmpty {
            return false
        }
        
        // ディレクトリを作成する
        let fileManager = NSFileManager.defaultManager()
        let result =
            fileManager.createDirectoryAtPath(dirPathName,
                                              withIntermediateDirectories: false,
                                              attributes: nil,
                                              error: error)
        return result;
    }
    
    /**
    ファイルを作成する。

    :param: filePathName ファイルパス名
    :param: error エラー
    :return: 作成結果 true:成功 / false:失敗
    */
    class func createFile(filePathName: String, error: NSErrorPointer) -> Bool {
        if filePathName.isEmpty {
            return false
        }
        
        let fileManager =  NSFileManager.defaultManager()
        let result =
            fileManager.createFileAtPath(filePathName, contents: nil, attributes: nil)
        return result
    }
    
    /**
    ファイルを削除する。

    :param: filePathName ファイルパス名
    :param: error エラー
    :return: 削除結果 true:成功 / false:失敗
    */
    class func deleteFile(filePathName: String, error: NSErrorPointer) -> Bool {
        if filePathName.isEmpty {
            return false
        }
        
        let fileManager = NSFileManager.defaultManager()
        let result =
            fileManager.removeItemAtPath(filePathName, error: error)
        return result
    }
    
    /**
    ファイルパス名からファイル名を切り出す。
    
    :param: filePathName ファイルパス名
    :return: ファイル名
    */
    class func getFileName(filePathName: String) -> String {
        if filePathName.isEmpty {
            return filePathName
        }
        
        return filePathName.lastPathComponent
    }

    /**
    パス名付きファイル名を取得する。
    
    :param: pathName パス名
    :param: fileName ファイル名
    :return: ファイルパス
    */
    class func getFilePath(pathName: String, fileName: String) -> String {
        return pathName.stringByAppendingPathComponent(fileName)
    }

    /**
    ファイル名リストを取得する。
    
    :param: pathName パス名
    :param: error エラー
    :return ファイル名のリスト
    */
    class func getFileNameList(pathName: String, error: NSErrorPointer) -> Array<String> {
        let fileManager = NSFileManager.defaultManager()
        let fileNameList =
            fileManager.contentsOfDirectoryAtPath(pathName, error: error)! as! Array<String>
        return fileNameList
    }

    /**
    ファイルかディレクトリか判別する。
    
    :param: path パス
    :return: 判別結果 FileType.Invalid 無効なファイル名
                     FileType.Directory ディレクトリ
                     FileType.File ファイル
    */
    class func isFileOrDirectory(path: String) -> FileType {
        let fileManager = NSFileManager.defaultManager()
        let error: NSErrorPointer = nil
        let dic: NSDictionary! = fileManager.attributesOfItemAtPath(path, error: error)
        if error != nil {
            return FileType.Invalid
        }
        let fileType = dic.fileType()
        if fileType == NSFileTypeDirectory {
            return FileType.Directory
        } else if fileType == NSFileTypeRegular {
            return FileType.File
        } else {
            return FileType.Invalid
        }
    }
    
    /**
    ファイルタイプを返却する

    :param: path ファイルパス
    :return: ファイルタイプ
    */
    class func getFileType(path: String) -> FileType {
        return FileType.File
    }
        
    /**
    ファイルにデータを書き出す。
    
    :param: fileName ファイル名
    :param: data データ
    :return: 処理結果 true:正常終了 / false:異常終了
    */
    class func writeFile(fileName: String, data: String) -> Bool {
        let result = data.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        return result
    }
    
    /**
    ファイルからデータを読み込む。
    
    :param: fileName ファイル名
    :return: 読み込んだデータ
    */
    class func readFile(fileName: String) -> String? {
        return String(contentsOfFile: fileName, encoding: NSUTF8StringEncoding, error: nil)
    }
}
