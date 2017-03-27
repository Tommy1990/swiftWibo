//
//  EPMComposeView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/27.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMComposeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
    addSubview(imgBack)
    addSubview(imgAds)
    
    imgBack.snp.makeConstraints { (make) in
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    imgAds.snp.makeConstraints { (make) in
        make.centerX.equalTo(self)
        make.top.equalTo(self).offset(100)
        }
    
    }
    
    //MARKE: 懒加载控件
    lazy var imgBack:UIImageView = {
        let img = UIImageView(image: UIImage.getScreenSnap()?.applyLightEffect())
        
        return img
    }()
 
    lazy var imgAds:UIImageView = UIImageView(image: UIImage(named: "compose_slogan"))
}
extension EPMComposeView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
}

