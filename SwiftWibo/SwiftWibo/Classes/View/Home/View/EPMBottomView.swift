//
//  EPMBottomView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMBottomView: UIView {
    override init(frame:CGRect)
    {
        super.init(frame: frame)
      self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        let retweetButton = addChildButtons(imgName: "timeline_icon_retweet", title: "转发")
        let commentButton = addChildButtons(imgName: "timeline_icon_comment", title: "评论")
        let unlikeButton = addChildButtons(imgName: "timeline_icon_unlike", title: "赞")
        
        let line1 = addChildLines()
        let line2 = addChildLines()

        //MARKE: 约束
        
        retweetButton.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(self)
            make.width.equalTo(commentButton)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(retweetButton)
            make.leading.equalTo(retweetButton.snp.trailing)
            make.width.equalTo(unlikeButton)
        }
        
        unlikeButton.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(self)
            make.leading.equalTo(commentButton.snp.trailing)
            
        }
        
        line1.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(retweetButton.snp.right)
        }
        
        line2.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(unlikeButton.snp.left)
            make.height.equalTo(self)
        }
        
        
        
    }
}

extension EPMBottomView{
    
    
    fileprivate func addChildButtons(imgName: String, title: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setImage(UIImage(named:imgName), for: UIControlState.normal)
        // 背景图片
        button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background_highlighted"), for: UIControlState.highlighted)
        // 添加控件
        addSubview(button)
        return button
    }
    
    /// 创建公共竖线方法
    ///
    /// - Returns: img
    fileprivate func addChildLines() -> UIImageView{
        let img = UIImageView(imgName: "timeline_card_bottom_line")
        // 添加控件
        addSubview(img)
        return img
    }
    
}
