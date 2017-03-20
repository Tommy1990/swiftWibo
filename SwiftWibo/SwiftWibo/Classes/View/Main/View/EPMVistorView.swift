//
//  EPMVistorView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/20.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SnapKit
protocol EPMVistorDelegate:NSObjectProtocol {
     func userLogingClick(visitorView:EPMVistorView)
     func userRegisterClick(visitorView:EPMVistorView)
}

class EPMVistorView: UIView {
    weak var delegate:EPMVistorDelegate?
   override init(frame: CGRect) {
    super.init(frame:frame)
    
    setupUI()
    }
    
    func resetUI(title:String,imageName:String,isHome:Bool = false)
    {
       
        cycleView.image = UIImage(named: imageName)
        bigHomeView.isHidden = !isHome
        coverView.isHidden = !isHome
        desLabel.text = title
        if isHome {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotatio")
        animation.toValue = 2*M_PI
        animation.duration = 15
        animation.repeatCount = 0
        animation.isRemovedOnCompletion = false
        cycleView.layer.add(animation, forKey: nil)
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
        ///位置约束
        cycleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(0)
            make.centerY.equalTo(self).offset(-70)
        }
        cycleView.sizeToFit()
        coverView.snp.makeConstraints { (make) in
            make.center.equalTo(cycleView)
        }
        coverView.sizeToFit()
        bigHomeView.snp.makeConstraints { (make) in
            make.center.equalTo(cycleView)
        }
        bigHomeView.sizeToFit()
        desLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(cycleView)
            make.top.equalTo(cycleView.snp.bottom).offset(17)
        }
        //文字不限行
        desLabel.numberOfLines = 0
        //设置文字最大行宽
        desLabel.preferredMaxLayoutWidth = self.bounds.size.width*0.7
        
        loadBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(desLabel)
            make.top.equalTo(desLabel.snp.bottom).offset(17)
            make.width.equalTo(100)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(desLabel)
            make.centerY.equalTo(loadBtn)
            make.width.equalTo(100)
        }
    
        //添加点击事件
        loadBtn.addTarget(self, action: #selector(loadBtnClick), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
    }
    //方法实现
    @objc private func loadBtnClick() {
        delegate?.userLogingClick(visitorView: self)
    }
    @objc private func registerBtnClick() {
        delegate?.userRegisterClick(visitorView: self)
        
    }
    
    //创建控件
    lazy var cycleView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    lazy var bigHomeView: UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"))
    lazy var coverView: UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_mask_smallicon"))
    lazy var desLabel: UILabel = UILabel(title: "登陆后点击关注更多", textColor:UIColor.darkGray , fontSize: 14)
    lazy var loadBtn: UIButton = UIButton(title: "登录", textColor: UIColor.orange, fontSize: 14, backImage: "common_button_white")
    
    lazy var registerBtn:UIButton = UIButton(title: "注册", textColor: UIColor.darkGray, fontSize: 14, backImage: "common_button_white")
    
    

}
