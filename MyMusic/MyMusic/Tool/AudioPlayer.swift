//
//  AudioPlayer.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit
import AVFoundation

enum States: Int {
    case isPlaying
    case isPrepare
    case stop
}

@objc protocol MusicDelegate {
    
    // 播放过程中
    optional func playWithProgress(progress: Float, player:AudioPlayer)
    // 播放完成
    optional func playEnd(player:AudioPlayer)
}


class AudioPlayer: NSObject {
    
    // 创建一个播放器
    let player = AVPlayer()
    
    // 定时器
    var timer: NSTimer?
    
    // 播放状态
    var states :States?
    
    // 创建代理属性
    var delegate: MusicDelegate?
    
    // 单例
    static var audioPlayer: AudioPlayer? = nil
    static func shareManager() ->AudioPlayer {
        if audioPlayer == nil {
            audioPlayer = AudioPlayer()
        }
        return audioPlayer!
    }
    
    override init() {
        
        super.init()
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playingEnd", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
    }
    
    
    // 准备播放
    func prepareToPlay(url: String) {
        
        // 判断当前是否有item，有的话移除观察者
        if (self.player.currentItem != nil) {
            self.player.currentItem?.removeObserver(self, forKeyPath: "status")
        }
        
        let playItem = AVPlayerItem(URL: NSURL(string: url)!)
        
        
        
        playItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.New, context: nil)
        self.player.replaceCurrentItemWithPlayerItem(playItem)
        
    }
    
    // 观察者
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "status" {
            
            self.states = States.isPrepare
            play()
//            self.player.play()
        
//            let status:  = change!["new"]
            
//            print(change!["new"])
//            let statu = change!["new"] as! NSNumber
//
//            switch status {
//            case 1:
//                print("filed")
//            case 2:
//                print("prepare")
//                self.player.play()
//            case 3:
//                print("unknown")
//            }
            
            
        }
    }
    
    // MARK: 播放
    func play() {
        // 如果准备好播放了再进行播放
        if self.states == States.isPrepare {
            self.player.play()
            self.states = States.isPlaying
        }
        
        if (self.timer != nil) {
            return
        }
        
        // 定时器
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        
    }
    
    // MARK:暂停
    func pause() {
        
        if !(self.states == States.isPlaying) {
            return
        }
        
        // 先暂停
        self.player.pause()
        self.states = States.stop
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // MARK: 停止
    func stop() {
        if !(self.states == States.isPlaying) {
            return
        }
        
        // 先暂停
        self.player.pause()
        
        // 播放时间设置到0秒
        self.player.seekToTime(CMTimeMake(0, self.player.currentTime().timescale) )
        self.states = States.stop
    }
    
    // MARK: 定时器方法
    func timerAction() {
        // 获取播放的时间进度
        let progress = self.player.currentTime().value / Int64(self.player.currentTime().timescale)
        
        self.delegate?.playWithProgress!(Float(progress), player: self)
    }
    
    // MARK: 通知方法
    func playingEnd() {
        self.delegate?.playEnd!(self)
    }
    
    // MARK: 从指定时间开始播放
    func seekToTime(time: Float64) {
        // 先暂停
        self.player.pause()
        
        self.player.seekToTime(CMTimeMakeWithSeconds(time, self.player.currentTime().timescale)) { (finished) -> Void in
            if finished {
                self.play()
            }
        }
    }
    

}
