//
//  EPMEPMDAL.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/4/4.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEPMDAL: NSObject {

    
    
    
    
    //MARKE: 读取数据
   class func getCache(since_id: Int64, max_id: Int64) ->[[String: Any]]{
        
        var tempArr: [[String: Any]] = [[String: Any]]()
        
        //获取userID
        guard let userID = EPMUserAccountModelView.shared.account?.uid else{
            return tempArr
        }
        
        // 首次需要在网络获取
        if since_id == 0 && max_id == 0 {
            return tempArr
        }
        
        // 准备sql
        var sql = ""
        sql += "SELECT * FROM T_Home\n"
        sql += "WHERE userid=\(userID)\n"
        // 下拉刷新
        if since_id > 0 {
            sql += "AND statusid>\(since_id)\n"
        }
        // 上拉加载更多
        if max_id > 0 {
            sql += "AND statusid<=\(max_id)\n"
        }
        sql += "ORDER BY statusid DESC\n"
        sql += "LIMIT 20"
        //执行SQL
       let result = EPMSQLManager.shearManger.selectDataWith(sql: sql)
        // 循环
        for dic in result {
            // 获取对应的二进制数据
            let data = dic["status"] as! Data
            // 转字典
            let dict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            // 保存到数组中
            tempArr.append(dict)
        }
        // 返回
        return tempArr
    }

}

//MARKE: 缓存数据
extension EPMEPMDAL{
    
    
   class func  saveCache(res:[[String: Any]]) {
        guard let userID = EPMUserAccountModelView.shared.account?.uid else{
            return
        }
        
        let sql = "INSERT OR REPLACE INTO T_Home (status,statusid,userid) VALUES (?,?,?)"
        EPMSQLManager.shearManger.queue.inTransaction { (db, rollback) in
            for dic in res{
                let statusid = dic["id"] as! Int64
                let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
                if db!.executeUpdate(sql, withArgumentsIn: [data,statusid,userID]){
                    print("保存数据成功")
                }else{
                    print("保存数据失败")
                    // 回滚
                    rollback?.pointee = true
                }
            }
        }
    
    }
}

//MARKE: 检查是否有缓存
extension  EPMEPMDAL{
    class func checkCache(sinceID: Int64, maxID: Int64, finished:@escaping (Any?)->()){
        // 读取微博缓存数据是否存在
        let result = getCache(since_id: sinceID, max_id: maxID)
        // 判断
        // 有缓存数据
        if result.count > 0 {
            print("----从本地加载微博数据")
            finished(result)
        }else{
            // 没有缓存数据
            print("----从网络加载微博数据")
            EPMNetworkingTool.shearedTool.loadHomeData(since_id: sinceID, max_id: maxID ) { (response, error) in
                // 请求失败
                if error != nil{
                    print("请求失败")
                    finished(nil)
                    return
                }
                // 判断是否为nil 而且是否是一个字典
                // 在if-let 或者 guard-let 中 转类型的时候 一般情况 都需要使用的是as?
                guard let res = response as? [String: Any] else{
                    finished(nil)
                    return
                }
                // 判断是否为nil 而且是否一个字典数组(默认情况下 微博数据是20条)
                guard let resArr = res["statuses"] as? [[String: Any]] else{
                    finished(nil)
                    return
                }
                // 再进行数据缓存
                saveCache(res: resArr)
                
                finished(resArr)
                
            }
            
        }
        
    }
    
}

//MARK:清理缓存数据
extension EPMEPMDAL{
    class func deleteCache(){
        // 获取当前的日期2017-04-02 16:48:04
        var currentDate = Date()
        // 测试
        currentDate = currentDate.addingTimeInterval(-16*60)
        // 时间格式化
        let df = DateFormatter()
        // 指定格式
        df.dateFormat = "YYYY-MM-dd HH:mm:ss"
        // 获取对应的字符串
        let currentTimeStr = df.string(from: currentDate)
        // 准备sql
        let sql = "DELETE FROM T_Home WHERE createtime<'\(currentTimeStr)'"
        
        // 执行sql
       
         EPMSQLManager.shearManger.queue.inDatabase { (db) in
            if db!.executeUpdate(sql, withArgumentsIn: nil){
                print("删除\(db?.changes() ?? 0)条缓存数据成功")
            }else{
                print("删除缓存数据失败")
            }
        }
    }
}

