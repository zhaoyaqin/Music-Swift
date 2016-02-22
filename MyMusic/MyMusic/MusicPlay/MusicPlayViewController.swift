//
//  MusicPlayViewController.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

let Identifier = "cell"

class MusicPlayViewController: UIViewController, MusicDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // 时间
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    // 播放进度条
    @IBOutlet weak var progress: UISlider!
    
    // 歌词
    @IBOutlet weak var lyricTableView: UITableView!
    // 图片
    @IBOutlet weak var playImageView: UIImageView!
    
    // 接收传值的model
    var musicModel:MusicModel?
    
    // 当前播放的音乐
    var currentMusic =  MusicModel()
    
    // 当前播放音乐的下标
    var index:Int?
    
    var currentIndex: Int?
    
    // 播放状态
    var isPlaying:Bool?
    
    // 下载工具
    var downLoadManager = DwonLoadManager()
    
    // 歌词
    var allLyricArray: NSArray?
    
    
    override func viewWillAppear(animated: Bool) {
        
        if self.currentIndex == self.index {
            return
        }
        
        self.currentIndex = self.index
        isPlaying = true
        self.startPlay()
//
        
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.lyricTableView.delegate = self
        self.lyricTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: 开始播放
    func startPlay() {
        
        if isPlaying == false {
            
            return
        }
        
        self.currentMusic = MusicManager.shareManager().allDataArray![self.currentIndex!] as! MusicModel
        
        // 准备播放
        AudioPlayer.shareManager().prepareToPlay(self.currentMusic.mp3Url!)
        
        // 设置代理
        AudioPlayer.shareManager().delegate = self
        
        // 更新界面
        updateUI()
        
    }
    
    // MARK: 更新UI
    func updateUI() {
        
        // 图片
//        playImageView.sd_setImageWithURL(NSURL(string: self.currentMusic.picUrl!), placeholderImage: UIImage(named: ""))
        
        // 时间
        // 总时间
//        self.totalTime.text = changeTimeToStr(Float(self.currentMusic.duration!)!)
        
        self.title = self.currentMusic.name
        
        // 进度条
        self.progress.maximumValue = Float(self.currentMusic.duration!)! / 1000
       
        
        // 歌词
        let allLyricArray = LyricManager.shareManager().getLyricWithModel(self.currentMusic)
        self.allLyricArray = NSArray(array: allLyricArray)
        self.lyricTableView.reloadData()
        
        
    }
    
    // MARK: 把时间转化
    func changeTimeToStr(time: Float) ->String {
        let m = String(time / 1000 / 60)
        let s = String(time % 60)
        
        
        
        return m + ":" + s
    }

    // MARK: 方法
    // 收藏
    
    @IBAction func collection(sender: UIButton) {
        
    }
    
    // 下载
    @IBAction func downLoad(sender: UIButton) {
        
        downLoadManager.downLoadWithUrl(self.currentMusic.mp3Url!)
    }
    
    // 暂停
    
    @IBAction func pauseAction(sender: UIButton) {
//        downLoadManager.pause()
    }
    // 继续
    @IBAction func resumeAction(sender: UIButton) {
//       downLoadManager.resume()
    }
    
    
    // 循环模式
    @IBAction func playType(sender: UIButton) {
    }
    
    // 上一曲
    @IBAction func up(sender: UIButton) {
        
        if self.currentIndex == 0 {
            
            self.currentIndex = (MusicManager.shareManager().allDataArray?.count)! - 1
        } else {
            self.currentIndex = self.currentIndex! - 1
        }
        startPlay()
    }
    
    // 下一曲
    
    @IBAction func next(sender: UIButton) {
        
        if self.currentIndex < MusicManager.shareManager().allDataArray?.count {
            self.currentIndex = self.currentIndex! + 1
        } else {
            self.currentIndex = 0;
        }
        
        startPlay()
    }
    // 播放/暂停
    @IBAction func play(sender: UIButton) {
        
        if AudioPlayer.shareManager().states == States.isPlaying {
            AudioPlayer.shareManager().pause()
            AudioPlayer.shareManager().states = States.isPrepare
        } else {
            AudioPlayer.shareManager().play()
        }
        
//        startPlay()
        
    }
    
    //MARK 音乐播放器代理方法
    func playWithProgress(progress: Float, player: AudioPlayer) {
        
        self.progress.value = progress
        
        // 播放时间
//        self.playTime.text = changeTimeToStr(progress)
        // 歌词滚动
        let index = LyricManager.shareManager().getLiricWithTime(progress)
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        self.lyricTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        
    }
    
    func playEnd(player: AudioPlayer) {
        
//        let button : UIButton? = nil
//        self.next(button!)
        if self.currentIndex < MusicManager.shareManager().allDataArray?.count {
            self.currentIndex = self.currentIndex! + 1
        } else {
            self.currentIndex = 0;
        }
        
        startPlay()
        
    }
    
    
    
    // MARK: tableViewDalegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.allLyricArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        var cell = tableView.dequeueReusableCellWithIdentifier(Identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Identifier)
        }
        let model = self.allLyricArray![indexPath.row] as! LyricModel
        cell?.textLabel?.text = model.lyric
        cell?.textLabel?.textAlignment = NSTextAlignment.Center
        cell?.textLabel?.highlightedTextColor = UIColor.redColor()
//        cell?.textLabel?.textColor = UIColor.whiteColor()
//        cell?.backgroundColor = UIColor.clearColor()
        let view = UIView(frame: cell!.bounds)
        view.backgroundColor = UIColor.clearColor()
        cell?.selectedBackgroundView = view
        return cell!
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
