//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/21.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

private let kCollectionCellID = "kCollectionCellID"
private let kEdgeInsetsMargin:CGFloat = 10

class RecommendGameView: UIView {
    
    //定义数据属性
    var groups:[AnchorGroup]?{
        didSet{
            
            //移除前面的四组数据
            groups?.removeSubrange(0...3)
            //添加更多的组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    //XIb属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kCollectionCellID)
        
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: kEdgeInsetsMargin, bottom: 0, right: kEdgeInsetsMargin)
    }

}

//MARK:快速创建实例
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK:DataSource
extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellID, for: indexPath) as! CollectionGameCell
        
        let group = groups![indexPath.item]
        
        cell.group = group
        
        return cell
        
    }
    
}
