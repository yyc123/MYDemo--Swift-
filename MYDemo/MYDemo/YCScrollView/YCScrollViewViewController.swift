//
//  YCScrollViewViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/8/15.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
let kTitleViewH :CGFloat = 40
class YCScrollViewViewController: BaseViewController {

    var titles: [String]!
    var titleView: ScrollTitleView!
    var contentView: PageContentView!
      
  

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()

             // Do any additional setup after loading the view.
    }
    func setupUI() {
        self.titles = ["推荐", "游戏", "娱乐", "趣玩","逗你玩"]
        
        titleView = ScrollTitleView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kTitleViewH), titles: titles)
        titleView.delegate = self
        var childVCs = [UIViewController]()
        //添加试图控制器
        for index in 0..<self.titles.count {
            let vc = TestViewController()
            vc.title = self.titles[index]
            childVCs.append(vc)
            
        }
        let contentFrame = CGRect(x: 0, y: 64 + kTitleViewH, width: kScreenWidth, height: kScreenHeight-(64 + kTitleViewH))
        contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        view.addSubview(titleView)
       view.addSubview(contentView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("释放")
    }
}
extension YCScrollViewViewController: PageContentViewDelegate,ScrollTitleViewDelegate{
   
    //滑动pageView
    func selectedpageContentView(_ contentView: PageContentView, currentIndex: Int) {
        titleView.setTitle(targetIndex: currentIndex);
    }
    //点击标题
    func selectedTitle(_ titleView: ScrollTitleView,index: Int){
        contentView.setCurrentIndex(index)

    }
}
