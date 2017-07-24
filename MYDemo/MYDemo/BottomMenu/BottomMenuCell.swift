//
//  BottomMenuCell.swift
//  MYDemo
//
//  Created by 德基 on 2017/7/22.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class BottomMenuCell: UITableViewCell {

    var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       self.backgroundColor = UIColor.white
        let line = UIView();
        contentView.addSubview(line)
        line.backgroundColor = Line_collor
        line.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0.5)
        }
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.ColorFromHexString(hexString: "#333333")
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0));
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setContent(content: String)  {
        titleLabel.text = content
        titleLabel.textColor = UIColor.ColorFromHexString(hexString: "#333333")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
