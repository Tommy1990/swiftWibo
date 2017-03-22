//
//  UIBarButtonItem+Extenssion.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    
    convenience init(title: String? = nil , imageName: String? ,target: Any?,action:Selector?) {
        
        let btn:UIButton = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        if let imageStr:String = imageName{
        btn.setImage(UIImage(named:imageStr), for: .normal)
          btn.setImage(UIImage(named:imageStr+"_highlighted"), for: .highlighted)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
       
        
        if let t = target , let s = action{
            
            btn.addTarget(t, action: s, for: .touchUpInside)
        }
        btn.sizeToFit()
        self.init()
        self.customView = btn
    }
    
}
