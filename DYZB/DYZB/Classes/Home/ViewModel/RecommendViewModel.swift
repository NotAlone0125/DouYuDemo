//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Foundation
/*
 首页数据地址：
 1.颜值、王者荣耀、手游休闲：https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios
 2.最热：https://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios 
 3.其他：https://capi.douyucdn.cn/api/v1/getHotCate
 */

private let prettyUrl = "https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios"
private let otherUrl = "https://capi.douyucdn.cn/api/v1/getHotCate"
private let hotUrl = "https://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios"

class RecommendViewModel {
    
    //MARK:懒加载属性
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    //缓存前两组数据
    fileprivate lazy var hotGroup:AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroups:[AnchorGroup] = [AnchorGroup]()
}

//MARK:loadData
extension RecommendViewModel{
    func loadData(finishCallback:@escaping () -> ()) {
        
        //利用dispath来让请求到的数据排序
        let dispatchGroup = DispatchGroup.init()
        
        //1.请求热门数据
        dispatchGroup.enter()//进入组
        NetworkTools.requestData(type: .Get, url: hotUrl, parameters: nil) { (returnResult) in
            
            self.hotGroup.tag_name = "热门"
            self.hotGroup.small_icon_url = "home_header_hot"

            for dict in self.jsonDataWithResult(returnResult: returnResult)!{
                let anchor = AnchorModel.init(dict: dict)
                self.hotGroup.anchors.append(anchor)
            }
            
            dispatchGroup.leave()//离开组
            print("请求到第一组数据")
        }
        
        //2.请求颜值等数据
        dispatchGroup.enter()//进入组
        NetworkTools.requestData(type: .Get, url: prettyUrl, parameters: nil) { (returnResult) in
            
            for dict in self.jsonDataWithResult(returnResult: returnResult)!{
                
                let group = AnchorGroup.init(dict: dict)
                self.prettyGroups.append(group)
                
            }
            dispatchGroup.leave()//离开组
            print("请求到第二组数据")
        }
        
        //3.请求其他数据
        dispatchGroup.enter()//进入组
        NetworkTools.requestData(type: .Get, url: otherUrl, parameters: nil) { (returnResult) in
            //print(returnResult)

            //遍历数组，获取字典，并且将字典转换成模型对象
            for dict in self.jsonDataWithResult(returnResult: returnResult)!{

                let group = AnchorGroup.init(dict: dict)
                self.anchorGroups.append(group)

            }
            dispatchGroup.leave()//离开组
            print("请求到第三组数据")
        }
        
        //所有数据请求完成后进行排序
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("所有数据都请求到")
            //先将颜值里面的AnchorGroup倒叙插入到数组的首位
            for prettyGroup in self.prettyGroups.reversed(){
                self.anchorGroups.insert(prettyGroup, at: 0)
            }
            //再将热门的数据导入到数组的首位
            self.anchorGroups.insert(self.hotGroup, at: 0)
            
            finishCallback()
        }
    }
}

extension RecommendViewModel{
    fileprivate func jsonDataWithResult(returnResult:AnyObject) -> [[String : NSObject]]?{
        
        //1.将returnResult转换为字典类型
        guard let resultDic = returnResult as? [String : NSObject] else {return nil}
        
        //2.根据data该key，获取数据
        guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return nil}
        
        return dataArray
    }
}
