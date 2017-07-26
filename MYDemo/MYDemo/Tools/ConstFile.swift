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
//沙盒路径
let SandboxPath = NSHomeDirectory()
//temp路径
let TempPath = NSTemporaryDirectory()
//Document路径
let  DocumentPath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//cache路径
let CachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first


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
//细体字体
func font_light(size:CGFloat) -> UIFont {
    if #available(iOS 8.2, *) {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightLight)
    } else {
        return UIFont(name:"HelveticaNeue-Light", size: size)!
        // Fallback on earlier versions
    }
}

//粗体体字体
func font_bold(size:CGFloat) -> UIFont {
    if #available(iOS 8.2, *) {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
    } else {
        return UIFont(name:"Helvetica-Bold", size: size)!
        // Fallback on earlier versions
    }
    
}
//身份证验证
func validateIdentityCard(num: String) -> Bool {
    if num.characters.count<=0 {
        return false
    }
    let RegEx = "^(\\d{14}|\\d{17})(\\d|[xX])$"
    let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@", RegEx)
    return identityCardPredicate.evaluate(with: num)
/*若要判断其他的，修改正则表达式即可：
  邮箱:[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}
 手机号：^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$
 */
}
