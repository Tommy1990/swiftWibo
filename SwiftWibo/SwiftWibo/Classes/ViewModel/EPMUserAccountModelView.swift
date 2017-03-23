//
//  EPMUserAccountModelView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/22.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

//定义公共地址
private let accountPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")


class EPMUserAccountModelView: NSObject {
 
    //单例封装
    static let shared : EPMUserAccountModelView = EPMUserAccountModelView()
    //私有化init方法形成绝对私有
    private override init()
    {
        super.init()
        
    }
    
    
    
    
    
    
    
    //请求用户授权
    func loadAccesToken(code: String ,finisedClouser: @escaping ((Bool)->())) {
        //请求地址
        let urlString = "https://api.weibo.com/oauth2/access_token"
        //请求的参数
        let paramter = [ "client_id" : client_id,
                         "client_secret" : client_secret,
                         "grant_type" : "authorization_code",
                         "code" : code,
                         "redirect_uri" : redirect_uri]
        //网络请求
        EPMNetworkingTool.shearedTool.request(method: .POST, urlString: urlString, paramter: paramter) { (res, error) in
            if error != nil{
                finisedClouser(false)
                return
            }
            //获取数据,开始加载用户信息
            self.loadUserInfo( res as! [String: Any], loadUserFinished: finisedClouser)
        }
    
    }
    
    //获得token
    func loadUserInfo(_ dict: [String: Any], loadUserFinished: @escaping ((Bool)->())){
        let urlString = "https://api.weibo.com/oauth2/get_token_info"
        let token = dict["access_token"]
        let uid = dict["uid"]
        let para = [ "access_token" : token,
                     "uid" : uid]
        EPMNetworkingTool.shearedTool.request(method: .POST, urlString: urlString, paramter: para) { (res, error) in
            if (error != nil){
                loadUserFinished(false)
                return
            }
            var userInfo = res as! [String:Any]
            
            for (key,value) in dict {
                //将字典中的数据存储到用户信息列表中
                userInfo[key] = value
            }
            //字典数据转模型
            let userAccount = EPMUserInfoModel(dict: userInfo)
            
            
            //存储数据
            self.userSaveAcoount(account: userAccount)
            //加载数据成功
            loadUserFinished(true)
            
        }
    }
    
    
    //归档方法
    private func userSaveAcoount(account: EPMUserInfoModel){
        
        NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
        
    }
    //解档方法
    
    private func loadUserAccount() -> EPMUserInfoModel?{
        
        let account  = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath)
        
        if let acc = account as? EPMUserInfoModel {
            return acc
        }
        return nil
    }
    
}
