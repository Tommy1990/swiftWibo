//
//  EPMComposeButton.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/28.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMComposeButton: UIButton {
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        //图片属性
        imageView?.contentMode = .center
        //label属性
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor.darkGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    //MARKE: 关闭高亮状态
   override var isHighlighted:Bool{
        get{
            //返回false即关闭高亮状态
            return false
        }
        set{
            
        }
    }
    
    //MARKE: 重写布局方法
    override func layoutSubviews() {
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width)
        titleLabel?.frame = CGRect(x: 0, y: self.frame.size.width, width: self.frame.size.width, height: self.frame.size.height-self.frame.size.width)
    }
}
