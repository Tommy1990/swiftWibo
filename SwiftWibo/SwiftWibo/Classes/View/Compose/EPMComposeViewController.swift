//
//  EPMComposeViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/28.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    //设置UI
    private func setupUI()
    {
        setupNavUI()
       view.addSubview(viewText)
        viewText.delegate = self
        viewText.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        
        
       
    }
    
    
    
    //设置导航栏
    private func setupNavUI() {
       navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", imageName: nil, target:self , action: #selector(cancelClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        sendButton.isEnabled = false
        navigationItem.titleView = labTitle
    }
    // 发送按钮
    fileprivate lazy var sendButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(sendAction), for: UIControlEvents.touchUpInside)
        button.frame.size = CGSize(width: 50, height: 30)
        button.setTitle("发送", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FONTSIZEOFNORMAL)
        button.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState.disabled)
        button.setBackgroundImage(UIImage(named:"common_button_orange"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named:"common_button_orange_highlighted"), for: UIControlState.highlighted)
        return button
    }()

    lazy var labTitle:UILabel = {
       
        let name = EPMUserAccountModelView.shared.account?.name ?? ""
        let text = "发微博" + "\n" + name
        let range = (text as NSString).range(of: name)
        
        let arr = NSMutableAttributedString(string: text)
        arr.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:ThemeColor], range: range)
        
         let lab = UILabel()
        lab.numberOfLines = 2
        lab.attributedText = arr
        lab.textAlignment = .center
        
        return lab
    }()
  
    fileprivate lazy var viewText: EPMComposeTextView = {
        let view = EPMComposeTextView()
        view.placeHolder = "发个微博记录下今天自己的心情吧!!!!^_^"
        view.font = UIFont.systemFont(ofSize: 16)
        view.alwaysBounceVertical = true
        return view
    }()
}
//MARKE: 点击方法实现
extension EPMComposeViewController{
    @objc fileprivate func cancelClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendAction() {
     print("保存按钮被点击了")
    }
    
}
//MARKE: textView的代理方法
extension EPMComposeViewController:UITextViewDelegate {
     func textViewDidChange(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.viewText.resignFirstResponder()
    }
}
