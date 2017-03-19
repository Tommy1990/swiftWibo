//
//  EPBaseNavigationController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPBaseNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let count = viewControllers.count
        
        if count > 0{
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", imageName: "navigationbar_back_withtext", target: self, action: #selector(back))
            viewController.view.backgroundColor = UIColor.white
            //隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func back(){
        let _ = self.popViewController(animated: true)
    }
    
    ///边缘点击代理方法
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let count = childViewControllers.count
        return count > 1
    }
}
