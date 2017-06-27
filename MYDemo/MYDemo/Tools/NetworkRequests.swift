//
//  NetworkRequests.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/27.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class NetworkRequests: NSObject {

    //单例
    static let shared: NetworkRequests = NetworkRequests()
    private override init() {
        
        print("初始化")
    }
}
