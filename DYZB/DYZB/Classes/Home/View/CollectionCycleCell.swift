//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/21.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel:CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            
            iconImageView.kf.setImage(with: URL.init(string: (cycleModel?.pic_url)!), placeholder: UIImage.init(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

}
