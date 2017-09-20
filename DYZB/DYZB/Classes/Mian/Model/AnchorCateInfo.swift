//
//  AnchorCateInfo.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/20.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class AnchorCateInfo: NSObject {

    //直播内容的类别
    var cate2_name:String = ""
    var cate1_name:String = ""
    //判断直播端是手机还是电脑(0:电脑，1:手机)
    var is_vertical:Int = 0
    //组显示的图标
    var icon_url:String = ""
    
    override init() {}
    
    init(dict:[String:NSObject]){
        
        print(dict)
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
