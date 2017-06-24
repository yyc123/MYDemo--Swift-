//
//  UIcollor+.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
extension UIColor{
    
    class func ColorFromHexString(hexString:String ) ->UIColor{
        
        return ColorFromHexStringWidhAlpha(hexString: hexString, alpha: 1.0)
        
    }
    class func ColorFromHexStringWidhAlpha(hexString:String,alpha:CGFloat) ->UIColor{
        
        if hexString.isEmpty {
            return UIColor.clear
        }
        /** 传进来的值。 去掉了可能包含的空格、特殊字符， 并且全部转换为大写 */
        
        var hex = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hex.characters.count<6 {
            return UIColor.clear
        }
        if hex.hasPrefix("0X") {
            
            hex = (hex as String).substring(from: hex.index(hex.startIndex, offsetBy: 2))
        }
        if hex.hasPrefix("#") {
            hex = (hex as String).substring(from: hex.index(hex.startIndex, offsetBy: 1))
        }
        if hex.hasPrefix("##") {
            hex = (hex as String).substring(from: hex.index(hex.startIndex, offsetBy: 2))
        }
        if hex.characters.count != 6 {
            return UIColor.clear
        }
        /** R G B */
        var range = NSMakeRange(0, 2)
        
        /** R */
        let rHex = (hex as NSString).substring(with: range)
        /** G */
        range.location = 2
        let gHex = (hex as NSString).substring(with: range)
        
        /** B */
        range.location = 4
        let bHex = (hex as NSString).substring(with: range)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        
    }

   
}
