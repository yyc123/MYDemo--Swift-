//
//  ConstFile.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import Foundation
import UIKit

//MARK: 常量设置


//debug模式输出(需配置 build Setting->other swift flags DEBUG)
func printDebug<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let strPath: String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "");
        print("\(strPath)\(methodName)[\(lineNumber)]: \(message)")
        
    #endif
}

//屏幕宽高
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width
//分割线颜色
let Line_collor  = UIColor.ColorFromHexString(hexString: "#e7e7e7")

//细体字体
let  font_light = "HelveticaNeue-Light"
//粗体体字体
let font_bold = "Helvetica-Bold"

//MARK:-判断真机模拟器
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
