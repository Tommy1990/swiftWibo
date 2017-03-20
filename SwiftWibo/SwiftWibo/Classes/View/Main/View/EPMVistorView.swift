//
//  EPMVistorView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/20.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SnapKit

class EPMVistorView: UIView {

   override init(frame: CGRect) {
    super.init(frame:frame)
    setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(cycleView)
        addSubview(coverView)
        addSubview(bigHomeView)
        addSubview(desLabel)
        addSubview(loadBtn)
        addSubview(registerBtn)
        
        
        
    }
    
    //创建控件
    lazy var cycleView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    lazy var bigHomeView: UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"))
    lazy var coverView: UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_mask_smallicon"))
    lazy var desLabel: UILabel = UILabel(title: "登陆后点击关注更多", textColor:UIColor.darkGray , fontSize: 14)
    lazy var loadBtn: UIButton = UIButton(title: "登录", textColor: UIColor.orange, fontSize: 14, backImage: "common_button_white")
    
    lazy var registerBtn:UIButton = UIButton(title: "注册", textColor: UIColor.darkGray, fontSize: 14, backImage: "common_button_white")
    
    

}
