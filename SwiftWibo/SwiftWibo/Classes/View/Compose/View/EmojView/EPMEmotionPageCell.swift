//
//  EPMEmotionPageCell.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEmotionPageCell: UICollectionViewCell {
    
    var indexpath : IndexPath?{
        didSet{
            label.text = "第\(indexpath!.section)组\n" + "第\(indexpath!.item)列"
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        contentView.addSubview(label)
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 20)
        label.sizeToFit()
        label.numberOfLines = 2
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
    }
    
    lazy var label: UILabel = UILabel()
    
}
