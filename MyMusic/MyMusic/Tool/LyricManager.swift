//
//  LyricManager.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/26.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class LyricManager: NSObject {
    
    // 保存所有的歌词
    var liricArray = NSMutableArray()
    
    // 下标
    var index: Int?
    
    // 时间
    var beginTime:Int?
    var endTime:Int?
    
    // 单例
    static var lyricManager : LyricManager? = nil
    static func shareManager() ->LyricManager {
        if lyricManager == nil {
            lyricManager = LyricManager()
        }
        return lyricManager!
    }
    
    // 根据模型分割歌词
    func getLyricWithModel(musicModel: MusicModel) ->NSArray {
        
        // 移除所有的歌词
        self.liricArray.removeAllObjects()
        
        // 根据“/n”分割每一行歌词
        let allLyric = musicModel.lyric?.componentsSeparatedByString("\n")
        // 遍历歌词的每一行 “[03:46.340]要是能重来 我要选李白”
        for lineLyric:String in allLyric! {
            // 通过“]”分割
           let lineLyricArray = lineLyric.componentsSeparatedByString("]")
            // 数组第一个元素为时间，第二个元素是歌词
            let time  = lineLyricArray.first
            // 通过“：”分割时间
            let allTime = time?.componentsSeparatedByString(":")
            
            let m = allTime?.first?.componentsSeparatedByString("[").last
            let s = allTime?.last
            
            // 把时间转换成float类型，计算总时间
            if m == "" && s == "" {
                break
            }
            let lineLiricTime = Float(m!)! * 60 + Float(s!)!
            
            let lyrics = lineLyricArray.last
            
            let lyricModel = LyricModel(lyric: lyrics!, time: lineLiricTime)
            
            
            self.liricArray.addObject(lyricModel)
            
        }
        
        return self.liricArray
    }
    
    // 根据时间返回歌词
    func getLiricWithTime(time: Float)->Int {
        
        // 遍历所有的歌词，比较歌词的时间和播放的时间
        for i in 0..<self.liricArray.count {
            let model = self.liricArray[i] as! LyricModel
            if model.time > time {
                index = i - 1 > 0 ? i - 1 : 0
                break
            }
        }
        
        return self.index!
    }
    
    
    
    

}
