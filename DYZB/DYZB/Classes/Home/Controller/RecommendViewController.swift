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
private let kItemH = kItemW * 3 / 4
private let kHearderViewH:CGFloat = 50

private let kNormalCellID = "kNormalCell"
private let kHeaderViewID = "kHeaderView"

class RecommendViewController: UIViewController {

    //MARK:懒加载属性
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
       
        //1.创建布局
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize.init(width: kItemW, height: kItemH)
        layOut.minimumInteritemSpacing = CGFloat(kItemMargin)
        layOut.minimumLineSpacing = 0
        layOut.headerReferenceSize = CGSize.init(width: kScreenW, height: kHearderViewH)
        //设置section的内边距
        layOut.sectionInset = UIEdgeInsets.init(top: 0, left: CGFloat(kItemMargin), bottom: 0, right: CGFloat(kItemMargin))
        
        //2.创建collectionView
        let collectionView = UICollectionView.init(frame: (self?.view.bounds)!, collectionViewLayout: layOut)
        collectionView.backgroundColor = UIColor.yellow
        collectionView.dataSource = self!
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]//高度和宽度随父控件的拉伸而拉伸
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
        
        
    }

}


//MARK:设置UI布局
extension RecommendViewController{
    
    fileprivate func setupUI(){
        
        self.view.addSubview(collectionView)
        
    }
    
}

//MARK:DataSource
extension RecommendViewController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.green
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.获取headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        headerView.backgroundColor = UIColor.red
        
        
        return headerView
    }
}
