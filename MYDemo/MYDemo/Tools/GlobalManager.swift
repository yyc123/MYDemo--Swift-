//
//  GlobalManager.swift
//  MYDemo
//
//  Created by 德基 on 2017/7/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import Foundation
import UIKit


//MARK:- 永久存取对象
func GET_OBJECT(key: String) -> Any{
    
    return UserDefaults.standard.object(forKey: key) ?? "无数据";
}
func REMOVE_OBJECT(key: String) {
    let def = UserDefaults.standard;
    def.removeObject(forKey: key);
    def.synchronize();
}
func SET_OBJECT(key: String,value: Any ) {
    let def = UserDefaults.standard;
    def.set(value, forKey: key);
    def.synchronize();
    
}
//获取缓存大小(M)
func getCacheSize() -> CGFloat {
    let Cpath = CachePath
    guard let enumerator = FileManager.default.enumerator(atPath: Cpath!) else {
        print("获取缓存失败")
        return 0
    }
    var count: UInt64 = 0
    
    for fileName in enumerator {
        
        let paths = (Cpath! as NSString).appendingPathComponent(fileName as! String)
        
        do {
            
            let fileDic = try FileManager.default.attributesOfItem(atPath: paths)
            
            count += (fileDic as NSDictionary).fileSize()
            
        } catch _ {}
       
    }
  
    let totalSize = CGFloat(count)/1024/1024
    return totalSize
}
//清理缓存
func clearCache(){
   
    let Cpath = CachePath
    //异步操作
    DispatchQueue.global().async {
        do {
            try FileManager.default.removeItem(atPath: Cpath!)
        } catch _ {}

    }
  
}
//延时加载
func delayLoad(time:Int) {
    let delay = DispatchTime.now() + .seconds(time)
    DispatchQueue.main.asyncAfter(deadline: delay) {
        
    }
}

