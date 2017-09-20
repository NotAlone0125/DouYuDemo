//
//  AnchorModel.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    //房间号
    var room_id:Int = 0
    //房间图片Url
    var vertical_src:String = ""
    //判断直播端是手机还是电脑(0:电脑，1:手机)
    var isVertical:Int = 0
    //房间名称
    var room_name:String = ""
    //主播名称
    var nickname:String = ""
    //在线人数
    var online:Int = 0
    //锁在城市
    var anchor_city:String = ""
    
    init(dict:[String:NSObject]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
