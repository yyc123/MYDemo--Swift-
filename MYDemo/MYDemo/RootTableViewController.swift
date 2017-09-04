//
//  RootTableViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class RootTableViewController: BaseTableViewController {

    let array = ["二维码",
                 "个人主页(头部下拉放大,导航栏透明)",
                 "底部弹出菜单",
                 "PlaceHolderTextView",
                 "导航标签栏与控制器联动"
        
                 ];
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NetworkRequests.shared)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = array[indexPath.row];

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let QRcodeVC =   QRCodeViewController()
            navigationController?.pushViewController(QRcodeVC, animated: true);
        case 1:
            let mineVC =   MineViewController()
            navigationController?.pushViewController(mineVC, animated: true);
        case 2:
            let menuVC =   MenuViewController()
            navigationController?.pushViewController(menuVC, animated: true);
        case 3:
            let textVC =   TextViewViewController()
            navigationController?.pushViewController(textVC, animated: true);
        case 4:
            let scrollVC =   YCScrollViewViewController()
            navigationController?.pushViewController(scrollVC, animated: true);

            
        default:
            return;
        }
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
