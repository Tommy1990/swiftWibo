//
//  EPMComposeViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/28.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SVProgressHUD
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
        view.addSubview(bottomView)
        viewText.delegate = self
        viewText.addSubview(pictureView)
        
        viewText.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
           
            make.height.equalTo(40)
        }
        
        pictureView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(screenWidth - 20)
            make.top.equalTo(self.viewText).offset(100)
        }
        pictureView.closure = {[weak self] in
            self?.addPictureBtnClick()
        }
       
        
        bottomView.clouser = {[weak self] (type) -> () in
            switch type {
            case .picture:
                print("图片")
               self?.addPictureBtnClick()
            case .emoticon:
                print("表情")
                self?.inputViewChanged()
            case .add:
                print("添加")
            case .trend:
                print("热门话题")
            case .mention:
                print("@")
            }
        }
        //监听
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChangeFrame), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addEmotionNoti(noti:)), name: NSNotification.Name(rawValue: EMOTIONADDBTNCLICK), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteEmotionNoti), name: NSNotification.Name(rawValue: EMOTIONDELETEBTNCLICK), object: nil)
        
        
        
    }
    
    
    //设置导航栏
    private func setupNavUI() {
       navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", imageName: nil, target:self , action: #selector(cancelClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
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
    
    fileprivate lazy var bottomView:EPMComposeBottomView = EPMComposeBottomView()
    fileprivate lazy var pictureView:EPMComposePictureView = {
        let view = EPMComposePictureView()
        view.isHidden = true
        return view;
    }()
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.view.endEditing(true)
    }
    fileprivate lazy var emojView: EPMEmojCollectionView = {
        let view = EPMEmojCollectionView()
        view.bounds.size = CGSize(width: screenWidth, height: 216)
        return view;
    }()
}
//MARKE: 点击方法实现
extension EPMComposeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @objc fileprivate func cancelClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendAction() {
    
     EPMNetworkingTool.shearedTool.senderWeibo(status: self.viewText.text) { (_, error) in
        if error != nil{
             SVProgressHUD.showError(withStatus: "发送失败")
        }else{
            SVProgressHUD.showSuccess(withStatus: "发送失败")
        }
        self.cancelClick()
        }
    }
    //底部视图图片按钮点击方法
    @objc fileprivate func addPictureBtnClick() {
        
        let imgPickerVC = UIImagePickerController()
        imgPickerVC.delegate = self
        present(imgPickerVC, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         picker.dismiss(animated: true, completion: nil)
        guard let img = info["UIImagePickerControllerOriginalImage"] as? UIImage else{
            return
        }
        pictureView.addImg(img: img)
        pictureView.isHidden = false
    }
    //emoj表情键盘
    fileprivate func inputViewChanged() {
        if viewText.inputView == nil{
            viewText.inputView = emojView;
            bottomView.emotionBtnName = "compose_keyboardbutton_background"
        }else{
            viewText.inputView = nil
            bottomView.emotionBtnName = "compose_emoticonbutton_background"
        }
        viewText.reloadInputViews()
        viewText.becomeFirstResponder()
    }
    
    @objc func addEmotionNoti(noti: Notification) {
        guard let model = noti.object as? EPMEmotionModel else {
            return
        }
        
        EPMEmotionTool.sheardTool.saveRecentEmoj(emojiModel: model)
        emojView.reloadRecntEmotionPage()
        if model.isEmoji{
            
            //是emoji表情
            let code = ((model.code ?? "") as NSString).emoji()
            viewText.insertText(code!)
        }else{
            let allAtt = NSMutableAttributedString(attributedString: viewText.attributedText)
            //图片表情
            let allpath = model.allPath ?? ""
            let img = UIImage(named: allpath, in: EPMEmotionTool.sheardTool.emotionBundle, compatibleWith: nil)
            let height = viewText.font!.lineHeight
            let att = EPMTextAttachment()
            att.emojiModel = model
            att.image = img
            att.bounds = CGRect(x: 0, y: -4, width: height, height: height)
            //创建不可变富文本
            let attr = NSAttributedString(attachment: att)
            //获取光标
            let selectRange = viewText.selectedRange
            
            allAtt.replaceCharacters(in: selectRange, with: attr)
            
            allAtt.addAttribute(NSFontAttributeName,value:UIFont.systemFont(ofSize:16), range: NSRange(location: 0, length: allAtt.length))
            
            viewText.attributedText = allAtt
            viewText.selectedRange = NSRange(location: selectRange.location + 1, length: 0)
            
            //系统辅助通知
            //激活发送按钮
            self.viewText.delegate?.textViewDidChange!(viewText)
            //隐藏占位文字
            NotificationCenter.default.post(name: Notification.Name.UITextViewTextDidChange, object: nil)
        }
        
        
        
        
    }
    @objc func deleteEmotionNoti (){
        //系统方法删去光标最近的文字
        viewText.deleteBackward()
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

extension EPMComposeViewController{
    @objc fileprivate func KeyboardWillChangeFrame(noti:Notification){
        // 判断noti.userInfo是否为nil
        guard let userInfo = noti.userInfo else {
            return
        }
        // 通过key获取到frame
        let frame = (userInfo["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        // 更新约束
        self.bottomView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view).offset(frame.origin.y - screenHeight)
        }
        // 获取动画时长
        let duration = (userInfo["UIKeyboardAnimationDurationUserInfoKey"] as! NSNumber).doubleValue
        
        // 设置动画
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }

    }
}
