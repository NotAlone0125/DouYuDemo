//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/21.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Foundation

private let kCollectionCellID = "collectionCellID"

class RecommendCycleView: UIView {
    
    //定义属性
    var cycleModels:[CycleModel]?{
        didSet{
            guard let cycleModels = cycleModels else {
                return
            }
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels.count
        }
    }
    
    //Xib属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置不随父控件拉伸
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCollectionCellID)
    }
    
    //获取更精确的collectionView的bounds
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

//MARK:提供一个快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        let recommendCycleView:RecommendCycleView = (Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as? RecommendCycleView)!
        
        return recommendCycleView
    }
}

//MARK:Datasource
extension RecommendCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellID, for: indexPath) as! CollectionCycleCell
        
        let cycleModel = cycleModels![indexPath.item]
        
        cell.cycleModel = cycleModel
        
        return cell
        
    }
}

//MARK:Delegate
extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
