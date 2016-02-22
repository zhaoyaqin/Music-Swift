//
//  MusicManager.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class MusicManager: NSObject {
    
    var allDataArray: NSMutableArray?
   
    
    
    
    
    
    // 单例方法
    static var manager: MusicManager? = nil
    static func shareManager() ->MusicManager {
        if manager == nil {
            manager = MusicManager()
        }
        return manager!
    }
    
    func downLoadMusicWithURL(url: String, block: (AnyObject) -> Void) {
        // 子线程获取数据
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            // 从网址获取数据
            let musicArray = NSArray(contentsOfURL: NSURL(string: url)!)
            // 初始化数组
            self.allDataArray = NSMutableArray()
            // 遍历数组，把字典转化成模型保存到数组中
            for item in musicArray! {
                self.allDataArray?.addObject(MusicModel.mj_objectWithKeyValues(item))
            }
            // 主线程回调
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // 回调block
                block(self.allDataArray!)
            })
        }
        
        
    }
    
    // 根据model取出下标
    func getIndexWithModel(musicModel: MusicModel) -> (Int) {
        let index = self.allDataArray?.indexOfObject(musicModel)
        return index!
    }
    

}
