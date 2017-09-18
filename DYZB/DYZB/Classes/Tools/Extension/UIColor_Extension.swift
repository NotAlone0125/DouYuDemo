//
//  UIColor_Extension.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/15.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
