//
//  EPMOrignialView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SnapKit

class EPMOrignialView: UIView {

     var selfConstraint:Constraint?
    override init(frame:CGRect){
        super.init(frame:frame)
//        self.backgroundColor = getRandomColor()
        setupUI()
        
    }
    
    var statueModel:EPMHomeStatueViewModel?{
        didSet{
            
            imgHead.EPM_setImage(urlString: statueModel?.homeModel?.user?.profile_image_url, placeholderImgName:"avatar_default")
            labuserName.text = statueModel?.homeModel?.user?.name
            imgMemberShip.image = statueModel?.MbrankImg
            labContent.text = statueModel?.homeModel?.text
            imgVarif.image = statueModel?.verifiedImg
            labSource.text = statueModel?.sourceText
            labCreatTime.text = statueModel?.timeText
            //判断视图逻辑
            selfConstraint?.deactivate()
            if let picUrls = statueModel?.homeModel?.pic_urls , picUrls.count > 0 {
                photoView.pic_urls = picUrls
                //更新约束
                self.snp.makeConstraints{ (make) in
                    selfConstraint = make.bottom.equalTo(photoView.snp.bottom).offset(margine).constraint
                }
                photoView.isHidden = false
                
            }else{
                self.snp.makeConstraints{ (make) in
                    selfConstraint = make.bottom.equalTo(labContent.snp.bottom).offset(margine).constraint
                }
                photoView.isHidden = true
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        addSubview(imgHead)
        addSubview(labuserName)
        addSubview(imgMemberShip)
        addSubview(labCreatTime)
        addSubview(labSource)
        addSubview(imgVarif)
        addSubview(labContent)
        addSubview(photoView)
       
        labContent.textAlignment = .left
        labContent.preferredMaxLayoutWidth = screenWidth - 2*margine
        //MARKE: 约束
        imgHead.snp.makeConstraints { (make) in
            make.leading.top.equalTo(self).offset(margine)
            make.width.height.equalTo(35)
        }
        labuserName.snp.makeConstraints { (make) in
            make.top.equalTo(imgHead)
            make.leading.equalTo(imgHead.snp.trailing).offset(margine)
        }
        imgMemberShip.snp.makeConstraints { (make) in
            make.centerY.equalTo(labuserName)
            make.leading.equalTo(labuserName.snp.trailing).offset(margine)
        }
        labCreatTime.snp.makeConstraints { (make) in
            make.leading.equalTo(imgHead.snp.trailing).offset(margine)
            make.bottom.equalTo(imgHead)
        }
        labSource.snp.makeConstraints { (make) in
            make.centerY.equalTo(labCreatTime)
            make.leading.equalTo(labCreatTime.snp.trailing).offset(margine)
        }
        imgVarif.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgHead.snp.bottom)
            make.centerX.equalTo(imgHead.snp.trailing)
        }
        labContent.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(screenWidth - 2*margine)
            make.top.equalTo(imgHead.snp.bottom).offset(margine)
            
        }
        photoView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(margine)
            make.width.equalTo(screenWidth - 2*margine)
            make.top.equalTo(labContent.snp.bottom).offset(margine)
        }
        
        self.snp.makeConstraints { (make) in
          selfConstraint = make.bottom.equalTo(photoView).offset(margine).constraint
        }
        
    }
    private lazy var imgHead:UIImageView = UIImageView(imgName: "avatar_default")
    private lazy var labuserName = UILabel(title: "昵称", textColor: UIColor.darkGray, fontSize: FONTSIZEOFNORMAL)
    private lazy var imgMemberShip = UIImageView(imgName: "common_icon_membership")
    private lazy var labCreatTime = UILabel(title: "微博时间", textColor: ThemeColor, fontSize: FONTSIZEOFSMALL)
    private lazy var labSource = UILabel(title: "微博来源", textColor: UIColor.darkGray, fontSize: FONTSIZEOFSMALL)
     private lazy var imgVarif = UIImageView(imgName: "avatar_vgirl")
    private lazy var labContent = UILabel(title: "微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文微博正文", textColor: UIColor.black, fontSize: FONTSIZEOFNORMAL)
    private lazy var photoView:EPMPictureView = EPMPictureView()
       
    
    
}
