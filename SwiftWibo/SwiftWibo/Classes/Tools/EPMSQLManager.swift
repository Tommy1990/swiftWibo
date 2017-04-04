//
//  EPMSQLManager.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/4/4.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import FMDB
private let dbName = "home.db"
class EPMSQLManager {

    static let shearManger:EPMSQLManager = EPMSQLManager()
    let queue :FMDatabaseQueue
    
     init() {
       let path = ((NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!) as NSString).appendingPathComponent(dbName)
        
         queue = FMDatabaseQueue(path: path)
    }
    
    
    
    fileprivate func creatTable(){
    //获取文件
        let file = Bundle.main.path(forResource: "db.sql", ofType: nil)
        let sql = try! String(contentsOfFile:file!)
        
        queue.inDatabase { (db) in
            if db!.executeStatements(sql){
                print("建表成功")
            }else{
                print("建表失败")
            }
        }
        
    }
    
    func selectDataWith(sql:String) -> [[String: Any]]{
        var tempArray: [[String: Any]] = [[String:Any]]()
        
        EPMSQLManager.shearManger.queue.inDatabase { (db) in
            guard let resSet = db?.executeQuery(sql, withArgumentsIn: nil) else{
                return
            }
            while resSet.next(){
                var dict: [String: Any] = [String: Any]()
                for i in 0..<resSet.columnCount() {
                    let key = resSet.columnName(for: i)
                    let value = resSet.object(forColumnIndex: i)
                    dict[key!] = value
                }
                tempArray.append(dict)
            }
        }
        return tempArray;
        
    }
    
}
