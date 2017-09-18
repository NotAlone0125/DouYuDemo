//
//  HomeViewController.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/14.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {

    //MARK:懒加载属性
    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        
        let titleFrame = CGRect.init(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        titleView.delegate = self!
        
        return titleView
    }()
    
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in//self对PageContentView有个强引用
        
        //frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect.init(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //子控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1.0)
            childVCs.append(vc)
        }
        
        let contentView = PageContentView.init(frame: contentFrame, childrenControls: childVCs, parentControl: self)
        contentView.delegate = self!
        return contentView
    }()
    
    //MARK:系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
    }
}

//MARK -- 设置UI界面
extension HomeViewController{
    fileprivate func setupUI(){
        //不需要调整UIScrollView的内边距(因为导航栏会影响scrollView)
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        self.setupNavigationBar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.yellow
    }
    
    fileprivate func setupNavigationBar(){
        
        //1.设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        //2.设置右侧item
        let size = CGSize.init(width: 44, height: 44)
        
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

//MARK:pagetitleView的协议
extension HomeViewController:PageTitleViewDelegate{
    func pageTitleViewSelect(pageTitleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCunrrentIndex(currentIndex: index)
    }
}

//MARK:PageContentViewDelegate的协议
extension HomeViewController:PageContentViewDelegate{
    func pageContentView(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleViewWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
