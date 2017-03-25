//
//  EPMHomeRetweetView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMHomeRetweetView: UIView {

    override init(frame:CGRect)
    {
        super.init(frame: frame)
//        self.backgroundColor = getRandomColor()
        setupUI()
    }
    var statueModel: EPMHomeStatueViewModel?{
        didSet{
            labReteetContent.text = statueModel?.homeModel?.retweeted_status?.text
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        addSubview(labReteetContent)
        labReteetContent.preferredMaxLayoutWidth = screenWidth - 2 * margine
        labReteetContent.textAlignment = .left
        labReteetContent.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(margine)
            make.centerX.equalTo(self)
            make.width.equalTo(screenWidth - 2 * margine)
           
        }
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(labReteetContent.snp.bottom).offset(margine)
        }
        
    }
    private lazy var labReteetContent =  UILabel(title: "转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文", textColor: UIColor.darkGray, fontSize: FONTSIZEOFNORMAL)
    
}
