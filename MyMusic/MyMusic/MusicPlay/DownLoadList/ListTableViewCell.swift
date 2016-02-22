//
//  ListTableViewCell.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/12/18.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // 歌曲名称
    @IBOutlet weak var name: UILabel!
    // 下载进度
    @IBOutlet weak var progress: UISlider!
    // 下载的状态
    @IBOutlet weak var status: UIButton!
    
    var model: DownModel? {
        didSet(newValue) {
            self.name.text = newValue?.name
            self.progress.value = (newValue?.progress)!
//            if newValue?.status == Int(Status.isLoading) {
//                self.status.setTitle("正在下载", forState: UIControlState.Normal)
//            }
        }
//        get {
//           return
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 暂停下载
    
    @IBAction func pause(sender: UIButton) {
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
