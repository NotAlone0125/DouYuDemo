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
    var timer:Timer?
    var cycleModels:[CycleModel]?{
        didSet{
            guard let cycleModels = cycleModels else {
                return
            }
            
            //加载数据
            collectionView.reloadData()
            
            //设置pageControl属性
            pageControl.numberOfPages = cycleModels.count
            
            //默认滚动到位置
            let indexPath = IndexPath.init(item: (cycleModels.count) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: false)
            
            //添加定时器
            removeTimer()
            addCycleTimer()
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
        return (cycleModels?.count ?? 0) * 100000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellID, for: indexPath) as! CollectionCycleCell
        
        let cycleModel = cycleModels![indexPath.item % (cycleModels?.count)!]
        
        cell.cycleModel = cycleModel
        
        return cell
        
    }
}

//MARK:Delegate
extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count)!
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK:定时器的操作
extension RecommendCycleView{
    fileprivate func addCycleTimer(){
        
        timer = Timer.init(timeInterval: 2.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        //获取要滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //滚动到该位置
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
}

