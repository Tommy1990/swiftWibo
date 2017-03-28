//
//  EPMMainTabBarController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addchildViewControllers()
        
        //添加tabBar
        let epmTabBar = EPMTabBar()
        
        self.setValue(epmTabBar, forKey: "tabBar")
        
        epmTabBar.clickClosure = {[weak self](tabBar:EPMTabBar) in
                
            let composeView = EPMComposeView()
            self?.view.addSubview(composeView)
        }
        
     
    }

   
    private func addchildViewControllers(){
        
        addChildController(VC: EPMHomeViewController(), title: "首页", imageName: "tabbar_home")
        
        addChildController(VC: EPMMessageViewController(), title: "消息", imageName: "tabbar_message_center")
        
        addChildController(VC: EPMDiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        
        addChildController(VC: EPMProfileViewController(), title: "我的", imageName: "tabbar_profile")
        
    }
    
    private func addChildController(VC:UIViewController ,title:String,imageName:String){
        VC.tabBarItem.title = title
        VC.navigationItem.title = title
        
        //图片
        VC.tabBarItem.image = UIImage(named: imageName)
        
        VC.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        VC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
        VC.tabBarItem.badgeValue = "10"
        VC.tabBarItem.badgeColor = UIColor.purple
        VC.tabBarItem.badgeValue = nil
        let nav = EPBaseNavigationController(rootViewController: VC)
        
        addChildViewController(nav)
        
        
    }


    

}
