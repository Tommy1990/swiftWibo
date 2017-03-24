//
//  EPMHomeStatueViewModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
//MARKE: 完成图片类的加载
class EPMHomeStatueViewModel: NSObject {
//MARKE: 生成HomeModel的属性
    var homeModel:EPMHomeModel? {
        didSet{
            MbrankImg = self.dealMbrankImage(mbrank: (homeModel?.user?.mbrank ?? 0))
            verifiedImg = self.dealVerifiedImage(verified: homeModel?.user?.verified ?? 0)
        }
    }
    
    override init() {
        super.init()
    }
    var MbrankImg: UIImage?
    var verifiedImg: UIImage?

}
//MARKE: 加载会员等级图片
extension EPMHomeStatueViewModel{
    func  dealMbrankImage(mbrank: Int)->UIImage?  {
        if mbrank>0 && mbrank<7{
            return  UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return UIImage(named: "common_icon_membership")
    }
}

//MARKE: 加载认证图片
extension EPMHomeStatueViewModel{
    func dealVerifiedImage(verified: Int) -> UIImage?{
        switch verified {
        case 1:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return UIImage(named: "avatar_vgirl")
        }
    }

    
    
}
