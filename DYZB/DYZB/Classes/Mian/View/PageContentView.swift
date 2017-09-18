//
//  PageContentView.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/15.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Foundation

private let collectionCellID = "cell"

class PageContentView: UIView {

    //MARK:定义属性
    fileprivate var childrenControls:[UIViewController]
    fileprivate var parentControl:UIViewController
    
    //MARK:懒加载属性
    fileprivate lazy var collection:UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        return collectionView
    }()
    
    
    //MARK:自定义构造函数
    init(frame: CGRect,childrenControls:[UIViewController],parentControl:UIViewController) {
        
        self.childrenControls = childrenControls
        self.parentControl = parentControl
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    convenience override init(frame: CGRect) {
        self.init(frame: frame, childrenControls: [UIViewController](), parentControl: UIViewController())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:设置UI界面
extension PageContentView{
    
    fileprivate func setupUI(){
        //1.添加子视图控制器
        for vc in childrenControls {
            parentControl.addChildViewController(vc)
        }
        
        //2.添加放置控制器View的collectionView
        addSubview(collection)
        collection.frame = self.bounds
        
    }
}

//MARK:DataSource协议
extension PageContentView:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childrenControls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = childrenControls[indexPath.item]
        childVC.view.frame = cell.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}
