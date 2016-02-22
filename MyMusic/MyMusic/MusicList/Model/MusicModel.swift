//
//  MusicModel.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class MusicModel: NSObject {
    
    var album: String?
    var artists_name: String?
    var blurPicUrl: String?
    var duration: String?
    var ID: String?
    var lyric: String?
    var mp3Url: String?
    var name: String?
    var picUrl: String?
    var singer: String?
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "id" {
            self.ID = value as? String
        }
    }
    
    

}
