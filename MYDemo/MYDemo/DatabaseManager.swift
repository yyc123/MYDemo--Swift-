//
//  DatabaseManager.swift
//  MYDemo
//
//  Created by 德基 on 2017/9/5.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
import FMDB
//FMDB简单封装使用

/** SQLite五种数据类型 */
let SQLTEXT =   "TEXT"
let SQLINTEGER = "INTEGER"
let SQLREAL =    "REAL"
let SQLBLOB =    "BLOB"
let SQLNULL =    "NULL"

class DatabaseManager: NSObject {
    
    let KFMDBName = "/MYDB.sqlite"
    let TABLE_NAME = "testTable"
    var fmdbQueue : FMDatabaseQueue!
    static let shared = DatabaseManager()
    private override init() {
        print("初始化")
    }
    func openDB() {
        let path = DocumentPath?.appending(KFMDBName);
        print(path!)
//        fmdbQueue = FMDatabaseQueue(path: path)
         creatTable(path, TABLE_NAME);
       
    }
    
    func creatTable(_ dbPath: String?,_ tableName:String?) {
        
        let db = FMDatabase(path: dbPath)
        guard db.open() else {
            print("数据库打开失败:\(db.lastErrorMessage())")
            return
        }
        let sql = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME)(id integer PRIMARY KEY AUTOINCREMENT, nickName \(SQLTEXT) NOT NULL;"
        do {
            try   db.executeUpdate(sql, values: nil)

        } catch  {
            print("创建表失败")
        }
        db.close()
    }
    func insertData(tableName:String?, data:NSDictionary) {
        let db = FMDatabase()
        guard db.open() else {
            print("数据库打开失败:\(db.lastErrorMessage())")
            return
        }
        var sqlUpdateFirst = "INSERT INTO" + TABLE_NAME + "("
        var sqlUpdateLast = " VALUES("
        for i in 0..<data.count {
            if i != data.count-1 {
                sqlUpdateFirst = sqlUpdateFirst + String(describing: data.allKeys[i]) + ","
                sqlUpdateLast = sqlUpdateLast + "?,"
            }else{
                sqlUpdateFirst = sqlUpdateFirst +  String(describing: data.allKeys[i]) + ")"
                sqlUpdateLast = sqlUpdateLast + "?)"
            }
        }
        do {
            try   db.executeUpdate(sqlUpdateFirst+sqlUpdateLast, values: nil)
            
        } catch  {
            print(db.lastErrorMessage())
            
        }
        db.close()
    }
//    func queryData() ->Dictionary<String, Any>{
//        let db = FMDatabase()
//        let sql = "SELECT * FROM " + TABLE_NAME
//        var dic = Dictionary<String, Any>()
//
//        guard db.open() else {
//            print("数据库打开失败:\(db.lastErrorMessage())")
//            return dic
//        }
//        do {
//         let result =   try db.executeQuery(sql, values: nil)
//            while result.next() {
////                result.string(forColumn: String)
////                dic.updateValue(<#T##value: Any##Any#>, forKey: <#T##String#>)
//                
//            }
//            
//        } catch  {
//            print(db.lastErrorMessage())
//
//        }
//    }
}
