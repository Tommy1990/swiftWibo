//
//  EPMEmotionModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEmotionModel: NSObject,NSCoding {
    // 16进制编码
    var code: String?
    // 如果type == "1" 代表是emoji表情
    var type: String?{
        didSet{
            isEmoji = (type == "1")
        }
    }
    // 图片描述
    var chs: String?
    // 图片名称
    var png: String?
    // 判断是否是emoji表情
    var isEmoji: Bool = false
    // 图片表情的全路径
    var allPath: String?
    
    override init(){
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        self.yy_modelEncode(with: aCoder)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.yy_modelInit(with: aDecoder)
    }
}
