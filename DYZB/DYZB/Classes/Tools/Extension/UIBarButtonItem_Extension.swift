//
//  UIBarButtonItem_Extension.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/14.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    
    //1.使用类方法创建（swift不建议）
/*
    class func createItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem.init(customView: btn)
    }
 */
    
    //2.使用构造函数
    //便利构造函数:1>convenience开头 2>在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero){
        
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highImageName != "" {
             btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        if size != CGSize.zero{
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
       
        self.init(customView: btn)
    }
}
