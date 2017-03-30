//
//  EPMbottombtnView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
enum EmojBtnType: Int {
    case recent = 2000
    case normal = 2001
    case emoj = 2002
    case lxh = 2003
}

class EPMbottombtnView: UIStackView {

    var currentBtn: UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setCurrentButton(index: Int) {
        let btn = viewWithTag(index + 2000) as! UIButton
        if btn == currentBtn{
            return
        }
        currentBtn?.isSelected = false
        btn.isSelected = true
        currentBtn = btn
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupUI(){
        backgroundColor = getRandomColor()
        axis = .horizontal
        distribution = .fillEqually
        
        addChildBtns(title: "最近", imgName: "compose_emotion_table_left", type: .recent)
        addChildBtns(title: "默认", imgName: "compose_emotion_table_mid", type: .normal)
        addChildBtns(title: "Emoji", imgName: "compose_emotion_table_mid", type: .emoj)
        addChildBtns(title: "浪小花", imgName: "compose_emotion_table_right", type: .lxh)
       
    }
    
    

}
extension EPMbottombtnView{
    
    fileprivate func addChildBtns(title: String,imgName:String,type:EmojBtnType) {
        let button =  UIButton()
        button.addTarget(self, action: #selector(btnclicked(btn:)), for: UIControlEvents.touchUpInside)
        button.tag = type.rawValue
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControlState.selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FONTSIZEOFNORMAL)
        button.setBackgroundImage(UIImage(named:"\(imgName)_normal"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named:"(imgName)_selected"), for: UIControlState.selected)
        // 设置默认的为选中的状态
        if type == .normal {
            button.isSelected = true
            currentBtn = button
        }
        
        addArrangedSubview(button)
        
    }
}

extension EPMbottombtnView{
   @objc fileprivate func btnclicked(btn:UIButton) {
        if btn == currentBtn{
            return
        }
        currentBtn?.isSelected = false
        btn.isSelected = true
        currentBtn = btn
    }
}
