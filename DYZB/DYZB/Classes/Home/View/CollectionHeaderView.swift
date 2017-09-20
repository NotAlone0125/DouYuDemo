//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //MARK:xib属性
    @IBOutlet weak var tagNameLabel: UILabel!
    
    @IBOutlet weak var tagIconImageView: UIImageView!
    
    //MARK:定义模型属性
    var group:AnchorGroup?{
        didSet{
            if group?.tag_name != "" {
                tagNameLabel.text = group?.tag_name
            }else{
                if group?.cateModel.cate2_name != ""{
                    tagNameLabel.text = group?.cateModel.cate2_name
                }else{
                    tagNameLabel.text = group?.cateModel.cate1_name
                }
            }
            tagIconImageView.image = getIconImageWithGroup(group: group!)
        }
    }
}

extension CollectionHeaderView{
    fileprivate func getIconImageWithGroup(group:AnchorGroup) -> UIImage{
        
        var returnImage:UIImage = UIImage()
        
        if group.tag_name != ""{//说明是第二和第三部分的数据 home_header_normal
            
            if group.small_icon_url.contains("https:"){//说明是网络图片
                let imageUrl = URL.init(string: group.small_icon_url)
                let imageData = try! Data.init(contentsOf:imageUrl!)
                returnImage = UIImage.init(data: imageData)!
            }else{
                returnImage = UIImage.init(named: group.small_icon_url)!
            }
        }else{
            let imageUrl = URL.init(string: group.cateModel.icon_url)
            let imageData = try! Data.init(contentsOf:imageUrl!)
            returnImage = UIImage.init(data: imageData)!
        }
        
        return returnImage
    }
}
