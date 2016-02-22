//
//  DownModel.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/12/18.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

enum Status:Int {
    case isLoading;
    case isWaiting;
}

class DownModel: NSObject {
    
    var name: String?
    var progress: Float?
    var status: States?
    

}
