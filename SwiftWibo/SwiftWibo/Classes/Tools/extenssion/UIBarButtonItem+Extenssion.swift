//
//  UIBarButtonItem+Extenssion.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    
    convenience init(title: String? = nil , imageName: String ,target: Any?,action:Selector?) {
        
        let btn:UIButton = UIButton()
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        
        if let t = target , let s = action{
            
            btn.addTarget(t, action: s, for: .touchUpOutside)
        }
        btn.sizeToFit()
        self.init()
        self.customView = btn
    }
    
}
