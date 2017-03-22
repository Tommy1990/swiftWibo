//
//  EPMOAuthViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/22.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMOAuthViewController: UIViewController,UIWebViewDelegate {

    lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    override func loadView() {
        self.view = webView
        webView.delegate = self
        self.navigationController?.navigationBar.isTranslucent = false
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //关闭视图穿透
        self.view.isOpaque = false
        //添加关闭按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", imageName: nil, target: self, action: #selector(close))
        //添加后门
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "走后门", imageName: nil, target: self, action: #selector(injectJason))
        
    }
    @objc private func injectJason(){
        
        let jsString = "document.getElementById('userId').value = 'leiggee@126.com' , document.getElementById('passwd').value = 'qazwsxedc'"
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
    
    
    
    @objc private func close() {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    
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
