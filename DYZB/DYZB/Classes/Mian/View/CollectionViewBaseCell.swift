//
//  CollectionViewBaseCell.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/20.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    
    //MARK:定义模型属性
    var anchor:AnchorModel?{
        didSet{
            //校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            
            //在线人数
            var onlineString:String = ""
            let online = anchor.online_num == 0 ? anchor.online : anchor.online_num
            if online >= 10000 {
                onlineString = "\(Int(online / 10000))万在线"
            }else{
                onlineString = "\(online)在线"
            }
            onlineButton.setTitle(onlineString, for: .normal)
            
            //昵称
            nickNameLabel.text = anchor.nickname
            
            //设置封面图片
            guard let imageUrl = URL.init(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: imageUrl as! Resource, placeholder: UIImage.init(named: "live_cell_default_phone"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
