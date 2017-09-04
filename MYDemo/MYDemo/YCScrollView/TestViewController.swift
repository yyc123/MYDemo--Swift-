//
//  TestViewController1.swift
//  MYDemo
//
//  Created by 德基 on 2017/8/15.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        let label = UILabel(frame: CGRect(origin: self.view.center, size: CGSize(width: 100, height: 100)));
        label.textColor = UIColor.black
        view.addSubview(label)
        label.text = self.title
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
