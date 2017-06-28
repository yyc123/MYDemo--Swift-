//
//  BaseTableViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/28.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.setNavigationBarHidden(false, animated: true);
        UIApplication.shared.statusBarStyle = .default;
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.black]
        //全局颜色设置
        UINavigationBar.appearance().tintColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)

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
