//
//  LyricModel.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/26.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

class LyricModel: NSObject {

    var lyric: String?
    var time: Float?
    
    init(lyric: String, time: Float) {
        super.init()
        self.lyric = lyric
        self.time = time
    }
}
