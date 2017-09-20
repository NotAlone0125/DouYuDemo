//
//  CollectionViewNormalCell.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/19.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionViewBaseCell {

    //MARK:控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    //MARK:定义模型属性
    override var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            //房间名称
            roomNameLabel.text = anchor?.room_name

        }
    }
    
}
