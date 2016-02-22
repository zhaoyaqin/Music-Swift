//
//  DownLoadOperation.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/12/22.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit



class DownLoadOperation: NSOperation {
    
    // model
    var model = MusicModel()
    // 当前正在下载的session
    
    // 下载的状态
    var isDownLoading: Int?
    // 下载的任务
    var task: NSURLSessionDownloadTask?
    
    // MARK: 暂停
    func downLoadPause() {
        
    }
    
    // MARK: 恢复
    func downLoadResule() {
        
    }
    
    func initWithDownLoadModel(model: MusicModel)->AnyObject {
        self.model = model
        return self
    }
    
    // MARK: 重写父类的方法
    override func main() {
        let configure = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let currentSession = NSURLSession(configuration: configure, delegate: self, delegateQueue: nil)
        
        let request = NSURLRequest(URL: NSURL(string: self.model.mp3Url!)!)
        self.task = NSURLSessionDownloadTask()
        
        
        
    }
    
    // MARK: 下载的代理方法
    
}
