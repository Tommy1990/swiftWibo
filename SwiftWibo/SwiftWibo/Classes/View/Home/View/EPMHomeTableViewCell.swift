//
//  EPMHomeTableViewCell.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit


class EPMHomeTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style ,reuseIdentifier:reuseIdentifier)
         setupUI()
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate lazy var originalView:EPMOrignialView = EPMOrignialView()
    fileprivate lazy var retweetView:EPMHomeRetweetView = EPMHomeRetweetView()
    fileprivate lazy var bottomView:EPMBottomView = EPMBottomView()
}

extension EPMHomeTableViewCell{
    
    fileprivate func setupUI() {
        contentView.addSubview(originalView)
        contentView.addSubview(retweetView)
        contentView.addSubview(bottomView)
        //MARKE: 约束
        originalView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self.contentView)
            make.height.equalTo(100)
        }
        
        retweetView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(originalView)
            make.top.equalTo(originalView.snp.bottom)
            make.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(retweetView)
            make.top.equalTo(retweetView.snp.bottom)
            make.height.equalTo(50)
            make.bottom.equalTo(self.contentView)
        }
        
        
        
    }
   
    
}

