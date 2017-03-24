//
//  EPMHomeViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMHomeViewController: EPMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let barBtn: UIBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(push))
        navigationItem.rightBarButtonItem = barBtn
        
        if !userLogIn {
            visitorView.resetUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
            //防止与正常的流程穿透
            return
        }
        
    }
    @objc private func push(){
        
        let VC = EPMTestViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
    
    
  

}
