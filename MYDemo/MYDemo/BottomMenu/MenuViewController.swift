//
//  MenuViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/7/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    lazy var button: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))
        btn.center = self.view.center;
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.setTitle("菜单", for: .normal)
        button.addTarget(self, action: #selector(displayMenu), for: .touchUpInside)
        button.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    func displayMenu()  {
        view.backgroundColor = UIColor.randomColor()
      let menuView =  BottomMenuView(dataArray: ["关注","分享","举报"])
        menuView.show { (index) in
            printDebug(index)
        }
        
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
