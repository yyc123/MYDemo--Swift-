//
//  MineViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/27.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
let MINECELL = "MINECELL"

//MARK:展示一个下拉放大效果
class MineViewController: BaseViewController {
    
    // head高度
    let  headHeght =  kScreenWidth/2;

    lazy var tableView: UITableView = {
       let table = UITableView(frame: CGRect(), style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: MINECELL)
        
        return table
    }()
    lazy var headView :UIView = {
        let  headView = UIView();
        headView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.headHeght)
        return headView
    }()
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg");
        imageView.contentMode = UIViewContentMode.scaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.headHeght);
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(0, 0, 0, 0));
            
        }
        
        setTableHeader()
    }
    func setTableHeader() {
        tableView.tableHeaderView = headView
        headView.addSubview(headImageView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  offsetY = scrollView.contentOffset.y;
        
        let height  = abs(offsetY)+headHeght;
        if offsetY < 0 {
            headImageView.frame = CGRect(x: 0, y: offsetY, width: kScreenWidth, height: height);
            
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: MINECELL)
        
        return cell!
    }
}
