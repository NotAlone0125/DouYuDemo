//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/21.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    //控件属性
    @IBOutlet weak var iconImageVIew: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义模型属性
    var group:AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageVIew.kf.setImage(with: URL.init(string: (group?.icon_url)!), placeholder: UIImage.init(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}
