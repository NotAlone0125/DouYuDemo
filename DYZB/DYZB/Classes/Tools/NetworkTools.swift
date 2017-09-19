//
//  NetworkTools.swift
//  AlamofireTest
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case Get
    case Post
}

class NetworkTools {
    class func requestData(type:MethodType,url:String,parameters:[String:NSString]? = nil,finishCallback:@escaping (_ result : AnyObject) -> ()){
        
        //1.获取类型
        let method = type == .Get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (returnResult) in
            guard let result = returnResult.result.value else {
                print((returnResult.result.error)!)
                return
            }
            
            finishCallback(result as AnyObject)
        }
    }
}
