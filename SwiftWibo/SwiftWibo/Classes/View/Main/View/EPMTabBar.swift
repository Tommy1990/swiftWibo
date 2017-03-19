//
//  EPMTabBar.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMTabBar: UITabBar {

    //添加闭包
    
    var clickClosure: ((EPMTabBar)->())?
    
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///设置UI
    private func setupUI(){
        
        self.addSubview(plusbtn)
        
        plusbtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        
        
    }
    
    @objc private func btnClick() {
    
        //回调闭包
        clickClosure?(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置控件size
        let w = self.bounds.size.width / 5
        let h = self.bounds.size.height
        
        var index = 0
        //遍历控件
        for subView in subviews{
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
            //重设宽高
            subView.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: h)
            
            index += (index == 1 ? 2 : 1)
            }
        }
        
        plusbtn.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        plusbtn.bounds.size = CGSize(width: w, height: h)
        
    }
    
    //懒加载加btn
    lazy var plusbtn: UIButton = {
        
        let plusBtn = UIButton()
        plusBtn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        plusBtn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
        plusBtn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        plusBtn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        return plusBtn
    }()
    

}
