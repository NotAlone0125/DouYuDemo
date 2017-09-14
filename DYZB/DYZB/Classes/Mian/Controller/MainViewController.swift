//
//  MainViewController.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/14.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let storyNameArray = ["Home","Live","Follow","Profile"]
        
        for name in storyNameArray {
            self.addChildVCWithName(storyBoardName: name)
        }
    }

    private func addChildVCWithName(storyBoardName:String){
        
        let childVC = UIStoryboard.init(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
        
    }

}
