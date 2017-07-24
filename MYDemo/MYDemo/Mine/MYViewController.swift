//
//  MYViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/28.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class MYViewController: MineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

        //目的:隐藏导航条下方线条
        navigationController?.navigationBar.shadowImage = UIImage()
        //设置title样式
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.white]
      
        hiddenNAVbar()
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MINECELL)
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let  offsetY = scrollView.contentOffset.y;
        if offsetY > headHeght-64 {
            self.title = "显示导航"
            printDebug(offsetY)
            let alpha = min(1, (offsetY - (headHeght-64))/64)
            printDebug(alpha)
            guard let navImage =  UIColor.createImageWithColor(UIColor(white: 0.0, alpha: alpha))  else {
                return
            }
            navigationController?.navigationBar.setBackgroundImage(navImage, for: .default)
            if alpha == 1 {
                navigationController?.navigationBar.tintColor = UIColor.white
                
            }
            
        }else{
           hiddenNAVbar()
        }
        

    }
    func hiddenNAVbar() {
        navigationController?.navigationBar.tintColor = UIColor.black
        self.title = ""
        guard let navImage =  UIColor.createImageWithColor(UIColor(white: 0.0, alpha: 0))  else {
            return
        }
        navigationController?.navigationBar.setBackgroundImage(navImage, for: .default)
    }
    override func viewDidDisappear(_ animated: Bool) {
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
