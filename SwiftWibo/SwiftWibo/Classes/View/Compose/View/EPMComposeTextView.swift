//
//  EPMComposeTextView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/28.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMComposeTextView: UITextView {
    var placeHolder:String?{
        didSet{
            labPlaceholder.text = placeHolder
        }
    }
    override var font: UIFont?{
        didSet{
            labPlaceholder.font = font
        }
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARKE: 设置界面
    func setupUI() {
        
        addSubview(labPlaceholder)
        
        labPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: labPlaceholder, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: labPlaceholder, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: labPlaceholder, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant:-10 ))
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewdidChanged), name: Notification.Name.UITextViewTextDidChange, object: nil)
    }
    
   fileprivate lazy var labPlaceholder: UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.darkGray
        lab.numberOfLines = 0
        return lab
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension EPMComposeTextView{
   @objc fileprivate func textViewdidChanged(){
        labPlaceholder.isHidden = self.hasText
    }
}

