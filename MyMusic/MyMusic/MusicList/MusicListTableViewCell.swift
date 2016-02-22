//
//  MusicListTableViewCell.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class MusicListTableViewCell: UITableViewCell {
    
    // 图片
    @IBOutlet weak var musicImage: UIImageView!
    // 歌名
    @IBOutlet weak var musicName: UILabel!
    // 歌手
    @IBOutlet weak var singer: UILabel!
    
    // model
    var musicModel:MusicModel? {
        didSet {
            self.musicName.text = musicModel?.name
            self.singer.text = musicModel?.singer
            
            self.musicImage.sd_setImageWithURL(NSURL(string: (musicModel?.picUrl)!), placeholderImage: UIImage(named: ""))
        }
    }
    
   
   static func createCellWithTableView(tableView: UITableView) ->UITableViewCell {
        let string = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(string)
        if cell == nil {
            cell = NSBundle().loadNibNamed("MusicListTableViewCell", owner: nil, options: nil).last as! MusicListTableViewCell
        }
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
