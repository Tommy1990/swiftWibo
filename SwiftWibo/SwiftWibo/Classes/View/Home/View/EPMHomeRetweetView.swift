//
//  EPMHomeRetweetView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SnapKit
class EPMHomeRetweetView: UIView {

    private var selfBottomConstraint:Constraint?
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 235/255, alpha: 1.0)
        setupUI()
    }
    var statueModel: EPMHomeStatueViewModel?{
        didSet{
            selfBottomConstraint?.deactivate()
            labReteetContent.text = statueModel?.homeModel?.retweeted_status?.text
            if let pic_urls = statueModel?.homeModel?.retweeted_status?.pic_urls ,pic_urls.count > 0 {
                photoView.pic_urls = pic_urls
                self.snp.makeConstraints{ (make) in
                  selfBottomConstraint = make.bottom.equalTo(photoView).offset(margine).constraint
                }
                photoView.isHidden = false
            }else{
                
                self.snp.makeConstraints{ (make) in
                    selfBottomConstraint = make.bottom.equalTo(labReteetContent).offset(margine).constraint
                }
                
                photoView.isHidden = true
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        addSubview(labReteetContent)
        addSubview(photoView)
        labReteetContent.preferredMaxLayoutWidth = screenWidth - 2 * margine
        labReteetContent.textAlignment = .left
        labReteetContent.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(margine)
            make.centerX.equalTo(self)
            make.width.equalTo(screenWidth - 2 * margine)
           
        }
        
        photoView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(margine)
            make.top.equalTo(labReteetContent).offset(margine)
            make.width.equalTo(screenWidth - 2 * margine)
        }
        
        self.snp.makeConstraints { (make) in
          selfBottomConstraint = make.bottom.equalTo(photoView).offset(margine).constraint
        }
        
    }
    private lazy var labReteetContent =  UILabel(title: "转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文转发微博正文", textColor: UIColor.darkGray, fontSize: FONTSIZEOFNORMAL)
    private lazy var photoView:EPMPictureView = EPMPictureView()
}
