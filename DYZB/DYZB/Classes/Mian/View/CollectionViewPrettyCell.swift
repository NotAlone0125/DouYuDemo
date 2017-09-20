//
//  CollectionViewPrettyCell.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//layer.cornerRadius,layer.masksToBounds

import UIKit

class CollectionViewPrettyCell: CollectionViewBaseCell {

    //定义控件属性
    @IBOutlet weak var cityButton: UIButton!
    
    //MARK:定义模型属性
    override var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            //城市
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
