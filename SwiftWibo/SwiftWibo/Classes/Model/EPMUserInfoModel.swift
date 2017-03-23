//
//  EPMUserInfoModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/23.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMUserInfoModel: NSObject,NSCoding {

    var acces_token :String?
    
    var expires_in : TimeInterval = 0 {
        didSet{
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    var expires_date : Date?
    
    var uid: String?
    var name: String?
     var avatar_large: String?
    
    //赋值方法
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
//    过滤
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //实现NSCoding协议
    //编码
    func encode(with aCoder: NSCoder) {
        aCoder.encode(acces_token, forKey: "acces_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    //解码
    required init?(coder aDecoder: NSCoder) {
        acces_token = aDecoder.decodeObject(forKey: "acces_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    
    
}
