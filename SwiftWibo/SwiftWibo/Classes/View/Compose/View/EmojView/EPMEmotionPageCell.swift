//
//  EPMEmotionPageCell.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEmotionPageCell: UICollectionViewCell {
    // 提供一个属性 供外界赋值
    var emoticons:[EPMEmotionModel]?{
        didSet{
            // 遍历按钮数组 隐藏按钮
            for button in emotionButtons{
                button.isHidden = true
            }
            // 赋值
            // 遍历外界传入的一维模型数组
            for (i, emoticonModel) in emoticons!.enumerated(){
                // 通过角标 获取对应按钮
                let button =  emotionButtons[i]
                    button.emotionModel = emoticonModel
                // 显示
                button.isHidden = false
                // 赋值 (如果emoji表情 赋值的title  如果是图片表情 赋值的image)
                // 判断是否是emoji表情
                if emoticonModel.isEmoji {
                    // 获取code
                    let code = ((emoticonModel.code ?? "") as NSString)
                    // 设置title
                    button.setTitle(code.emoji(), for: UIControlState.normal)
                    button.setImage(nil, for: UIControlState.normal)
                    
                }else{
                    // 图片表情
                    let image = UIImage(named: emoticonModel.allPath ?? "" , in: EPMEmotionTool.sheardTool.emotionBundle, compatibleWith: nil)
                    button.setImage(image, for: UIControlState.normal)
                    button.setTitle(nil, for: UIControlState.normal)
                }
            }
        }
    }

    
    var indexpath : IndexPath?{
        didSet{
//            label.text = "第\(indexpath!.section)组\n" + "第\(indexpath!.item)列"
            
        }
    }
    var emotionButtons:[EPMEmotionBtn] = [EPMEmotionBtn]()
    
    
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
        self.addChildBtns()
        self.contentView.addSubview(deleteButton)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 计算出20个表情按钮的宽度和高度
        let buttonW: CGFloat = (screenWidth - 10)/CGFloat(HMEMOTICONMAXCOL)
        let buttonH: CGFloat = (216 - 35 - 20)/CGFloat(HMEMOTICONMAXROW)
        // 正向遍历
        for (i, button) in (emotionButtons.enumerated()){
            // 计算列数和行数
            let col = CGFloat(i%HMEMOTICONMAXCOL)
            let row = CGFloat(i/HMEMOTICONMAXCOL)
            // 设置按钮的frame
            button.frame = CGRect(x: col*buttonW + 5, y: row*buttonH, width: buttonW, height: buttonH)
        }
        // 设置删除按钮的frame
        deleteButton.frame = CGRect(x: screenWidth - buttonW - 5, y: buttonH*2, width: buttonW, height: buttonH)
    }
    fileprivate lazy var deleteButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(named:"compose_emotion_delete"), for: UIControlState.normal)
        button.setImage(UIImage(named:"compose_emotion_delete_highlighted"), for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside)
        return button
    }()
    //MARK: 懒加载控件
    fileprivate lazy var messageLabel: UILabel = {
        let lab = UILabel(title: "", textColor: UIColor.red, fontSize: 30)
        return lab
    }()
    
    lazy var label: UILabel = UILabel()
    
}
extension EPMEmotionPageCell{
    
    fileprivate func addChildBtns() {
        
        for _ in 0 ..< HMEMOTICONMAXCOUNT{
            let btn = EPMEmotionBtn()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
           emotionButtons.append(btn)
            contentView.addSubview(btn)
            btn.addTarget(self, action: #selector(addBtnClick(btn:)), for: .touchUpInside)
        }
    }
    
}
  //MARK:点击事件
extension EPMEmotionPageCell{
    @objc fileprivate func deleteBtnClick() {
    NotificationCenter.default.post(name:NSNotification.Name(rawValue: EMOTIONDELETEBTNCLICK) , object: nil)
    }
    @objc fileprivate func addBtnClick(btn:EPMEmotionBtn) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:EMOTIONADDBTNCLICK), object: btn.emotionModel)
        
    }
    
}


