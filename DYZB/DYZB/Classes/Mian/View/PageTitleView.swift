//
//  PageTitleView.swift
//  DYZB
//
//  Created by 杨昱航 on 2017/9/15.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

import UIKit

//MARK:定义协议
protocol PageTitleViewDelegate:class {
    func pageTitleViewSelect(pageTitleView:PageTitleView,selectedIndex index:Int)
}

//MARK:定义常量
private let kScrollLineH:CGFloat = 2.0
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {

    //MARK:定义属性
    fileprivate var currentLabelIndex:Int = 0
    fileprivate var titles:[String]
    weak var delegate:PageTitleViewDelegate?
    
    //MARK:懒加载属性
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView:UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false//设置UIScrollView是否需要弹簧效果
        
        return scrollView
    }()
    
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK:自定义一个构造函数
    init(frame: CGRect,titles:[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    convenience override init(frame: CGRect) {
        self.init(frame: frame, titles: [String]())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{
    
    fileprivate func setupUI(){
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomMenuAddScrollLine()
    }
    
    private func setupTitleLabels(){
        
        //定义一些frame的值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in  titles.enumerated(){
            
            let label = UILabel()
            
            //设置属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1.0)
            label.textAlignment = .center
            
            //设置Frame
            let labelX:CGFloat = CGFloat(index) * labelW
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //为Label添加属性
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.titleLabelTapGes(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    private func setupBottomMenuAddScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect.init(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1.0)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}

//MARK:titleLabel事件监听
extension PageTitleView{
    @objc func titleLabelTapGes(tapGes:UITapGestureRecognizer){
        //1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //2.获取之前的label
        let oldLabel:UILabel = titleLabels[currentLabelIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1.0)
        oldLabel.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1.0)
        
        //保存新的labelIndex
        currentLabelIndex = currentLabel.tag
        
        //4.滚动条位置发生改变
        let scorllLineX = CGFloat(currentLabelIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) { 
            self.scrollLine.frame.origin.x = scorllLineX
        }
        
        //5.调用代理方法
        delegate?.pageTitleViewSelect(pageTitleView: self, selectedIndex: currentLabelIndex)
    }
}

//MARK:对外暴露的方法
extension PageTitleView{
    func setTitleViewWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int)  {
        //1.取出sourceLabel和targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        
        //3.颜色的渐变
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress, a: 1.0)
        
        //3.3变化targetLabel
        targetLabel.textColor = UIColor.init(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress, a: 1.0)
        
        //4.记录currentIndex
        currentLabelIndex = targetIndex
    }
}


