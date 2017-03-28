//
//  EPMComposeView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/27.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import pop
class EPMComposeView: UIView {

    var target:UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
    addSubview(imgBack)
    addSubview(imgAds)
    addSubBtns()
    imgBack.snp.makeConstraints { (make) in
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    imgAds.snp.makeConstraints { (make) in
        make.centerX.equalTo(self)
        make.top.equalTo(self).offset(100)
        }
    
    }
    
    //MARKE: 懒加载控件
    lazy var imgBack:UIImageView = {
        let img = UIImageView(image: UIImage.getScreenSnap()?.applyLightEffect())
        
        return img
    }()
 
    lazy var imgAds:UIImageView = UIImageView(image: UIImage(named: "compose_slogan"))
    lazy var btnArr:[EPMComposeButton] = [EPMComposeButton]()
}
extension EPMComposeView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        btnAnimation(isUP: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            self.removeFromSuperview()
        }
    }
}


//MARKE: 对外接口
extension EPMComposeView{
    
    func showView(target:UIViewController) {
        let composeView = EPMComposeView()
         composeView.target = target
        target.view.addSubview(composeView)
        btnAnimation(isUP: true)
    }
    
}


//MARKE: btn按键
extension EPMComposeView{
    
    //MARKE:添加按键
    fileprivate func addSubBtns() {
        let btnWidth:CGFloat = 80
        let btnHeight:CGFloat = 120
        let btnMargine = (screenWidth - btnWidth*3)/4
        let btnModelArr = loadData()
        for (i,model) in btnModelArr.enumerated() {
            let row = CGFloat (i / 3)
            let col = CGFloat (i % 3)
            let btn = EPMComposeButton()
            btn.setImage(UIImage(named:model.icon ?? ""), for: .normal)
            
            btn.setTitle(model.title!, for: .normal)

            btn.frame = CGRect(x: btnMargine+(btnMargine+btnWidth)*col, y: (btnMargine+btnHeight)*row, width: btnWidth, height: btnHeight+screenHeight)
            btn.composeModel = model
            
            btnArr.append(btn)
            btn.addTarget(self, action: #selector(clickBtnAction(btn:)), for: .touchUpOutside)
            addSubview(btn)
        }
        
    }
    fileprivate func btnAnimation(isUP:Bool) {
        let msrginY = isUP ? -350 : 350
        let btnList = isUP ? btnArr : btnArr.reversed()
        for (i,button) in btnList.enumerated(){
            // 实例化弹簧动画对象
            let anSpring = POPSpringAnimation(propertyNamed: kPOPViewCenter)!
            // 设置toValue
            anSpring.toValue = CGPoint(x: button.center.x, y: button.center.y + CGFloat(msrginY))
            // 开始时间 CACurrentMediaTime() 系统绝对时间
            anSpring.beginTime = CACurrentMediaTime() + Double(i)*0.025
            // 振幅
            anSpring.springBounciness = 10.0
            // 设置动画
            button.pop_add(anSpring, forKey: nil)
            
            
        }
        
        
    }
    
    @objc fileprivate func clickBtnAction(btn:EPMComposeButton) {
        
        
        
        
    }
    
}





//MARKE: 数据加载
extension EPMComposeView{
    fileprivate func loadData()->[EPMComposeModel] {
        
        let path = Bundle.main.path(forResource: "compose.plist", ofType: nil)!
        let tempArray = NSArray(contentsOfFile: path)!
        let btnArray = NSArray.yy_modelArray(with: EPMComposeModel.self, json: tempArray) as! [EPMComposeModel]
        return btnArray
        
        
    }
}

