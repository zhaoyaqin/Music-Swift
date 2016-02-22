//
//  DwonLoadManager.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/25.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class DwonLoadManager: NSObject, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate {
    
    var task = NSURLSessionDownloadTask()
    var session = NSURLSession()
    var data = NSData()
    
    override init() {
        super.init()
        
       
       session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
    }
    
    // 根据url下载数据
    func downLoadWithUrl(url: String) {
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let task = session.downloadTaskWithRequest(request)
        
        task.resume()
    }
    
    // 暂停
    func pause() {
        print("暂停")
        task.suspend()
//       task.cancelByProducingResumeData { (resumeData) -> Void in
//        self.data = resumeData!
//        
//        }
    }
    
    
    // 继续下载
    func resume() {
//        session?.downloadTaskWithResumeData(self.data)
        task.resume()
    }
    
   
    // MARK: 下载的代理方法
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        // 拿到caches文件夹
        let caches = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        // 拿到caches文件夹和文件名
        
        let url = NSURL.fileURLWithPath(caches!)
        let fileUrl = url.URLByAppendingPathComponent(((downloadTask.response?.URL)?.lastPathComponent)!)
        // 判断是否存在
        let musicFile = NSFileManager.defaultManager()
        
        if musicFile.fileExistsAtPath(fileUrl.path!) {
//            musicFile.removeItemAtURL(fileUrl)
        }
//        musicFile.moveItemAtURL(location, toURL: fileUrl)
        
       
        
        
        print(location)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    // 无论成功还是失败都会调用此方法
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print(task)
        print(error)
    }
    
}
