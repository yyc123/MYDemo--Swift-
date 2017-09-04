//
//  ScrollTitleView.swift
//  MYDemo
//
//  Created by 德基 on 2017/8/15.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

protocol ScrollTitleViewDelegate: class {
    func selectedTitle(_ titleView: ScrollTitleView,index: Int)

}
class ScrollTitleView: UIView {

    fileprivate var currentIndex = 0
    fileprivate var titles: [String]
    weak var delegate: ScrollTitleViewDelegate?
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces  = false
        return scrollView
    }()
    lazy var titlelabels: [UILabel] = [UILabel]()
    //自定义init
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //设置界面
   fileprivate func setupUI()  {
    
    addSubview(scrollView)
    scrollView.frame = self.bounds
    
    let labelW: CGFloat = frame.width/CGFloat(titles.count)
    let labelH: CGFloat = frame.height
    for (index,title) in titles.enumerated() {
        let label = UILabel()
        label.text = title
        label.tag = index
        label.font = UIFont .systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.textAlignment = .center
        let labelX: CGFloat = labelW * (CGFloat(index))
        label.frame = CGRect(x: labelX, y: 0, width: labelW, height: labelH)
        scrollView.addSubview(label)
        titlelabels.append(label)
        label.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
        label.addGestureRecognizer(tapGes)
        if label.tag == 0 {
            titleLabelClick(tapGes)
        }
        
    }
    
        
    }

}

extension ScrollTitleView{
    
    @objc fileprivate func titleLabelClick(_ tap: UITapGestureRecognizer) {
        guard let currentLabel = tap.view as? UILabel else { return  }
        
        if currentLabel.tag == currentIndex {
            if currentIndex == 0 {
                //默认第0个选中
                currentLabel.textColor = UIColor.red
            }
            return
        }
        
        let oldLabel = titlelabels[currentIndex]
        currentLabel.textColor = UIColor.red
        oldLabel.textColor = UIColor.black
        
        currentIndex = currentLabel.tag
        delegate?.selectedTitle(self, index: currentIndex)
        
    }
    func setTitle(targetIndex: Int) {
        
        if targetIndex == currentIndex {
            return
        }
        
        let currentLabel = titlelabels[targetIndex]
        let oldLabel = titlelabels[currentIndex]
        currentLabel.textColor = UIColor.red
        oldLabel.textColor = UIColor.black
        currentIndex = targetIndex
    }
   
}
