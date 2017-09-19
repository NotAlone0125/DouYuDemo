//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    //该组的房间列表
    var room_list:[[String : NSObject]]?{
        didSet{//效果等同于下面重写的（func setValue(_ value: Any?, forKey key: String) ）
            guard let room_list = room_list else {
                return
            }
            for dict in room_list{
                anchors.append(AnchorModel.init(dict: dict))
            }
        }
    }
    //组显示的名称
    var tag_name = ""
    //组显示的图标
    var icon_url:String = "home_header_normal"
    //定义主播的模型对象数组
    lazy var anchors:[AnchorModel] = [AnchorModel]()
    
    init(dict:[String:NSObject]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
    //json中有些字典不被用到，放止出错，重新下面方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
   
    //转换为AnchorModel数组
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list"{
//            if let dataArray = value as? [[String : NSObject]]{
//                for dict in dataArray{
//                    anchors.append(AnchorModel.init(dict: dict))
//                }
//            }
//        }
//    }
}
