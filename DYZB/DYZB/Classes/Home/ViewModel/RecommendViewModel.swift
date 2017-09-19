//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

/*
 首页数据地址：
 1.颜值、王者荣耀、手游休闲：https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios
 2.最热：https://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios 
 3.其他：https://capi.douyucdn.cn/api/v1/getHotCate
 */

private let otherUrl = "https://capi.douyucdn.cn/api/v1/getHotCate"

class RecommendViewModel {
    
    //MARK:懒加载属性
    fileprivate lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    
}

//MARK:loadData
extension RecommendViewModel{
    func loadData() {
        
        //1.请求热门数据
        
        //2.请求颜值等数据
        
        //3.请求其他数据
        NetworkTools.requestData(type: .Get, url: otherUrl, parameters: nil) { (returnResult) in
            //print(returnResult)
            
            //1.将returnResult转换为字典类型
            guard let resultDic = returnResult as? [String : NSObject] else {return}
            
            //2.根据data该key，获取数据
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //3.遍历数组，获取字典，并且将字典转换成模型对象
            for dict in dataArray{
                
                let group = AnchorGroup.init(dict: dict)
                self.anchorGroups.append(group)
                
            }
            
            for group in self.anchorGroups{
                //print(group.tag_name)
                for anchor in group.anchors{
                    print(anchor.nickname)
                }
                print("++++++++++")
            }
        }
    }
}
