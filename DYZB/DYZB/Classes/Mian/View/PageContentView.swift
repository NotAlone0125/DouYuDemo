//
//  PageContentView.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/15.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit
import Foundation

protocol PageContentViewDelegate:class {
    func pageContentView(progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let collectionCellID = "cell"

class PageContentView: UIView {

    //MARK:定义属性
    fileprivate var childrenControls:[UIViewController]
    fileprivate weak var parentControl:UIViewController?//这里的parentControl就是指的HoumeViewController，所以形成了循环引用，要使用weak修饰符。
    fileprivate var startOffsetX:CGFloat = 0
    weak var delegate:PageContentViewDelegate?
    var isForbidScrollDelegate:Bool = false//避免点击title时候，多余执行scrollViewDelegate
    
    
    //MARK:懒加载属性
    fileprivate lazy var collection:UICollectionView = {[weak self] in//闭包中使用self也会产生循环引用
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
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
    init(frame: CGRect,childrenControls:[UIViewController],parentControl:UIViewController?) {
        
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
            parentControl?.addChildViewController(vc)
        }
        
        //2.添加放置控制器View的collectionView
        addSubview(collection)
        collection.frame = self.bounds
        
    }
}

//MARK:DataSource协议
extension PageContentView:UICollectionViewDataSource{
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

//MARK:UICollectionViewDelegate
extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {//如果是点击的title，不执行代理方法，节省资源
            return
        }
        
        //1.定义需要获取的数据
        var progress:CGFloat = 0
        var targetIndex:Int = 0
        var sourceIndex:Int = 0
        
        //2.判断滑动的方向
        let currentoffsetX = scrollView.contentOffset.x
        let scrollW = scrollView.bounds.width
        if currentoffsetX > startOffsetX {//左滑
            //1.计算progress
            progress = currentoffsetX / scrollW - floor(currentoffsetX / scrollW)
            
            //2.计算sourceIndex
            sourceIndex = Int(currentoffsetX / scrollW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex > childrenControls.count {//防止越界
                targetIndex = childrenControls.count - 1
            }
            
            //4.如果完全滑过去
            if currentoffsetX - startOffsetX == scrollW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{//右滑
            //1.计算progress
            progress = 1 - (currentoffsetX / scrollW - floor(currentoffsetX / scrollW))
            
            //2.计算targetIndex
            targetIndex = Int(currentoffsetX / scrollW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex > childrenControls.count {//防止越界
                sourceIndex = childrenControls.count - 1
            }
        }
        
        //将三个变量传递给titleView
        print("progress\(progress) sourceIndex\(sourceIndex) targetIndex\(targetIndex)")
        delegate?.pageContentView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:对外暴露的方法
extension PageContentView{
    func setCunrrentIndex(currentIndex:Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collection.frame.width
        collection.setContentOffset(CGPoint.init(x: offsetX, y: 0) , animated: false)
    }
}
