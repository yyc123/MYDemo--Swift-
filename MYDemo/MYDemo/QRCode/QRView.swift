//
//  QRView.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/26.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class QRView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        addScanRang(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //范围
    func addScanRang(frame:CGRect)  {
        
        let borderview = UIImageView(frame: frame)
        let mainPath = Bundle.main.resourcePath
        guard mainPath != nil else {
            return
        }
       
        borderview.image = UIImage(contentsOfFile:  (mainPath?.appending("/扫一扫.png"))!)
        self.addSubview(borderview)
        
        let line = UIImageView(frame: CGRect(x: frame.origin.x, y: frame.origin.y+5, width: frame.size.width, height: 2))
        line.image = UIImage(contentsOfFile: (mainPath?.appending("/QRline.png"))!)
        self.addSubview(line)
        UIView.animate(withDuration: 2.5, delay: 0, options: .repeat, animations: { 
            line.frame = CGRect(origin: CGPoint(x: frame.origin.x, y: frame.size.height-10), size: line.frame.size)
        }) { (_) in
            line.frame = CGRect(origin: CGPoint(x: frame.origin.x, y: frame.origin.y+5), size: line.frame.size)

        }

    }
}
