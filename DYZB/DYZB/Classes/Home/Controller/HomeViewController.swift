//
//  HomeViewController.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/14.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
    }
}

//MARK -- 设置UI界面
extension HomeViewController{
    fileprivate func setupUI(){
    
        //1.设置导航栏
        self.setupNavigationBar()
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
