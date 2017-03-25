//
//  EPMHomeModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMHomeModel: NSObject {
    // MARK: - 模型属性
    /// 创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 用户信息
    var user: EPMHomeUserModel?
    ///转发微博
    var retweeted_status: EPMHomeModel?
}
