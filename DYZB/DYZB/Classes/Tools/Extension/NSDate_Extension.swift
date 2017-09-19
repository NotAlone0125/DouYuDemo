//
//  NSDate_Extension.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String{
        
        let nowDate = NSDate.init()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
}
