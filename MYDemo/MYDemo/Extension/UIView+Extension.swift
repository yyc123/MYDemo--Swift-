//
//  UIView+.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/27.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

import SnapKit
extension UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // 查找view所在的vc
    func responderViewController() -> UIViewController {
        var responder: UIResponder! = nil
        var next = self.superview
        while next != nil {
            responder = next?.next
            if (responder!.isKind(of: UIViewController.self)){
                return (responder as! UIViewController)
            }
            next = next?.superview
        }
        return (responder as! UIViewController)
    }

}
