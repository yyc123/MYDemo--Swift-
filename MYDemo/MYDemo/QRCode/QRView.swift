//
//  QRView.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/26.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class QRView: UIView {

    private var line: UIImageView!
    private var myFrame: CGRect?

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
        
      line = UIImageView(frame: CGRect(x: frame.origin.x, y: frame.origin.y+5, width: frame.size.width, height: 2))
      line.image = UIImage(contentsOfFile: (mainPath?.appending("/QRline.png"))!)
        self.addSubview(line)
        myFrame = frame
       
    }
    func startAnimation() {
        
        guard let frame = self.myFrame else { return  }
        UIView.animate(withDuration: 2.5, animations: {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.line.frame.origin.y = frame.size.height-10
        }) { (_) in
            self.line.frame.origin.y = frame.origin.y+5
            
        }
    }
}
