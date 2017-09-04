//
//  BaseViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/27.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        //即使不存在导航栏也能左滑返回
        navigationController?.interactivePopGestureRecognizer?.delegate =  self as? UIGestureRecognizerDelegate

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.black]
        self.navigationController!.setNavigationBarHidden(false, animated: true);
        UIApplication.shared.statusBarStyle = .default;
        //全局颜色设置
        UINavigationBar.appearance().tintColor = UIColor.black
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
