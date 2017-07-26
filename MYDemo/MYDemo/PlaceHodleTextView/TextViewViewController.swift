//
//  TextViewViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/7/26.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class TextViewViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let textview = UIPlaceHolderTextView(frame: CGRect(x: 100, y: 200, width: 200, height: 100));
        textview.placeholder = "这是一段占位符"
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.blue.cgColor
        textview.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(textview)
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
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
