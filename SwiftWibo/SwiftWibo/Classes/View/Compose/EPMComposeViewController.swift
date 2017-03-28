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
        self.view.backgroundColor = getRandomColor()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
       navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", imageName: nil, target:self , action: #selector(cancelClick))
    }

    
}
//MARKE: 点击方法实现
extension EPMComposeViewController{
    @objc fileprivate func cancelClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
