//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/18.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

private let kItemMargin = 10
private let kItemW = (kScreenW - CGFloat(3 * kItemMargin)) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHearderViewH:CGFloat = 50

private let kCycleViewH:CGFloat = kScreenW * 3 / 8
private let kGameViewH:CGFloat = 90

private let kNormalCellID = "kNormalCell"
private let kPrettyCellID = "kPrettyCell"
private let kHeaderViewID = "kHeaderView"

class RecommendViewController: UIViewController {

    //MARK:懒加载属性
    fileprivate lazy var recommendVM:RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
       
        //1.创建布局
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize.init(width: kItemW, height: kNormalItemH)
        layOut.minimumInteritemSpacing = CGFloat(kItemMargin)
        layOut.minimumLineSpacing = 0
        layOut.headerReferenceSize = CGSize.init(width: kScreenW, height: kHearderViewH)
        //设置section的内边距
        layOut.sectionInset = UIEdgeInsets.init(top: 0, left: CGFloat(kItemMargin), bottom: 0, right: CGFloat(kItemMargin))
        
        //2.创建collectionView
        let collectionView = UICollectionView.init(frame: (self?.view.bounds)!, collectionViewLayout: layOut)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self!
        collectionView.delegate = self!
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        //xib注册UICollectionReusableView和collectionViewCell
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib.init(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]//高度和宽度随父控件的拉伸而拉伸
        
        return collectionView
    }()
    
    fileprivate lazy var cycleView:RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect.init(x: 0, y: -kCycleViewH - kGameViewH, width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()
    
    fileprivate lazy var gameView:RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect.init(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()

        //发送网络请求
        loadData()
    }
}


//MARK:设置UI布局
extension RecommendViewController{
    
    fileprivate func setupUI(){
        //添加collectionView
        self.view.addSubview(collectionView)
        
        //将cycleView添加到collectionView
        collectionView.addSubview(cycleView)
        //设置collectionView的内边距来显示负坐标的cycleView
        collectionView.contentInset = UIEdgeInsets.init(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        //添加gameView
        collectionView.addSubview(gameView)
    }
    
}

//MARK:请求数据
extension RecommendViewController{
    fileprivate func loadData(){
        
        //请求推荐数据
        recommendVM.loadData {
            self.collectionView.reloadData()
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        
        //请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK:DataSource、Delegate
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        
        //定义cell
        var cell:CollectionViewBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        }
        
        cell.anchor = anchor
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1.获取headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
    
        return headerView
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize.init(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize.init(width: kItemW, height: kNormalItemH)
        }
    }
}

