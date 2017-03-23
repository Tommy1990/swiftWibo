//
//  EPMWelcomViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/23.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SDWebImage

class EPMWelcomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //即将展示时调用
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    private func setupUI(){
      view.addSubview(iconView)
      view.addSubview(welcomeLabel)
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-180)
            make.width.height.equalTo(85)
        }
        iconView.sd_setImage(with:EPMUserAccountModelView.shared.headIconUrl)
        
        welcomeLabel.snp.makeConstraints {(make) in
            make.centerX.equalTo(self.view).offset(0)
            make.top.equalTo(iconView.snp.bottom).offset(17)
        }
        
        iconView.layer.cornerRadius = 42.5
        iconView.layer.masksToBounds = true
        
        welcomeLabel.alpha = 0
        self.view.layoutIfNeeded()
    }
    
   private func startAnimation()  {
    
        let offset = UIScreen.main.bounds.height - 180 - 87.5
        iconView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-offset)
         }
    
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: [], animations: { 
            self.view.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 1, animations: { 
                self.welcomeLabel.alpha = 1
            }, completion: { (true) in
             UIApplication.shared.keyWindow?.rootViewController = EPMMainTabBarController()
            })
    }
    
    
    
    }
    
    
    lazy var iconView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "avatar_default_big"))
    lazy var welcomeLabel :UILabel = UILabel(title: "欢迎回来", textColor: UIColor.darkGray, fontSize: 15)
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
