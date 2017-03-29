//
//  EPMComposeBottomView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/29.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
enum EPMComposeBottomViewType:Int {
    // 图片
    case picture = 1000
    // @
    case mention = 1001
    // #
    case trend = 1002
    // 表情
    case emoticon = 1003
    // +
    case add = 1004
}

class EPMComposeBottomView: UIView {

    var clouser:((EPMComposeBottomViewType)->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        backgroundColor = UIColor(patternImage: UIImage(named:"compose_toolbar_background")!)
        let pictureBtn = addbutton(imgName: "compose_toolbar_picture", type: .picture)
        let mentionbtn = addbutton(imgName: "compose_mentionbutton_background", type: .mention)
        let trendBtn = addbutton(imgName: "compose_trendbutton_background", type: .mention)
        let emotionBtn = addbutton(imgName: "compose_emoticonbutton_background", type: .emoticon)
        let addBtn = addbutton(imgName: "compose_add_background", type: .add)
        
        pictureBtn.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(self)
            make.width.equalTo(mentionbtn)
        }
        mentionbtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(pictureBtn.snp.trailing)
            make.width.equalTo(trendBtn)
        }
        trendBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(mentionbtn.snp.trailing)
            make.width.equalTo(emotionBtn)
        }
        emotionBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(trendBtn.snp.trailing)
            make.width.equalTo(addBtn)
        }
        addBtn.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(self)
            make.leading.equalTo(emotionBtn.snp.trailing)
        }
    }
}
extension EPMComposeBottomView{
    
    
    fileprivate func addbutton(imgName: String, type: EPMComposeBottomViewType)-> UIButton{
        
        let btn = UIButton()
        btn.tag = type.rawValue
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        btn.setImage(UIImage(named:imgName), for: UIControlState.normal)
        btn.setImage(UIImage(named:"\(imgName)_highlighted"), for: UIControlState.highlighted)
        // 添加控件
        addSubview(btn)
        return btn
    }
    @objc fileprivate func btnClick(btn:UIButton) {
        clouser?(EPMComposeBottomViewType(rawValue: btn.tag)!)
    }
}
