//
//  BottomMenuView.swift
//  MYDemo
//
//  Created by 德基 on 2017/7/22.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
let MENUCELLID = "MENUCELLID"

class BottomMenuView: UIView {

    let menuCellHeight: CGFloat = 44.0
    var finishBack: ((Int) -> Void)?
    var dataArray: Array<String>!
    var rect: CGRect!
    lazy var tableView: UITableView = {
        let table = UITableView(frame: self.rect, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(BottomMenuCell.self, forCellReuseIdentifier: MENUCELLID)
        table.isScrollEnabled = false
        table.backgroundColor = UIColor.ColorFromHexString(hexString: "f5f6f8")
        table.separatorStyle = .none
        return table
    }()
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(dataArray: Array<String>){
        self.init(frame: .zero)
        self.dataArray = dataArray
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        rect = self.bounds
        let height = CGFloat((dataArray.count+2))*menuCellHeight+12
        rect.origin.y = rect.size.height - height
        rect.size.height = height
        self.addSubview(tableView)

        
    }

    func show(callBack:@escaping ((Int)->Void))  {
        self.finishBack = callBack
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        self.alpha = 0
        tableView.transform = CGAffineTransform(translationX: 0, y: tableView.frame.size.height)
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
            self.tableView.transform = CGAffineTransform.identity;
        }
    }
    func cancel()  {
        UIView.animate(withDuration: 0.3, animations: { 
            self.alpha = 0
            self.tableView.transform = CGAffineTransform(translationX: 0, y: self.tableView.frame.size.height)
            
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.cancel()
    }
      /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension BottomMenuView:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return dataArray.count + 1
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 12
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return menuCellHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BottomMenuCell = tableView.dequeueReusableCell(withIdentifier: MENUCELLID) as! BottomMenuCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.selectionStyle = .none
                cell.titleLabel.text = "操作";
                cell.titleLabel.textColor = UIColor.ColorFromHexString(hexString: "#ababab")
            }else{
                cell.setContent(content: dataArray[indexPath.row-1])
            }
        }
        if indexPath.section == 1 {
            cell.setContent(content: "取消")

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0&&indexPath.row == 0 {
            
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        //-1是因为第一行固定显示"操作",直接返回数据array的索引值
        if finishBack != nil {
            finishBack!(indexPath.row-1)
        }
        cancel()
    }
}
