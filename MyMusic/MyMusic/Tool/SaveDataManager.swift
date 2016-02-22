//
//  SaveDataManager.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

var db: FMDatabase?

class SaveDataManager: NSObject {
    
    
    // 单例
    static var dataManager: SaveDataManager? = nil
    static func shareManager() -> SaveDataManager {
        if dataManager == nil {
            dataManager = SaveDataManager()
        }
        return dataManager!
    }
    

    override init() {
        // 数据库路径
//        let path = String.stringByAppendingString("\(NSHomeDirectory())/Library/Cache/Data.db")
        let fileManager = NSFileManager.defaultManager()
        
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        let url = NSURL(string: docsDir)
        let databasePath = String(url?.URLByAppendingPathComponent("music.db"))
        // 创建数据库
        db = FMDatabase(path: databasePath)
        
        print(databasePath)
        // 打开数据库
        db?.open()
        // 创建表
        let sqlStr = "CREATE TABLE IF NOT EXISTS music(id TEXT, dic TEXT)"
        let result = db?.executeUpdate(sqlStr, withArgumentsInArray: nil)
        
        if result == true {
            print("创建表成功")
        } else {
            
        }
        
        // 关闭数据库
        db?.close()
        
//        if !fileManager.fileExistsAtPath(databasePath) {
//            
//        }
//        
        
    }
    
    func saveDataWithDic(dic: Dictionary<String, AnyObject>) {
        
        // 打开数据库
        db?.open()
        
        // 插入数据
        
        
    }

}
