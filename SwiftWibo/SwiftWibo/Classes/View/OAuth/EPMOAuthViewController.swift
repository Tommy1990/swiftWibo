//
//  EPMOAuthViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/22.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SVProgressHUD
class EPMOAuthViewController: UIViewController {

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
        //加载网络页面
        loadOAuthPage()
        
    }
    //视图消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
   //注入现有账号完成后门设置
    @objc private func injectJason(){
        
        let jsString = "document.getElementById('userId').value = 'leiggee@126.com' , document.getElementById('passwd').value = 'qazwsxedc'"
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
    //取消验证方法设置
    @objc private func close() {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    //设置weiBo端口
    private func loadOAuthPage()
    {
        let urlString = "https://api.weibo.com/oauth2/authorize?"+"client_id=" + client_id + "&redirect_uri=" + redirect_uri
        
        let url = URL(string: urlString)
        //验证是否为空
        guard let u = url else{
            return
        }
       let request = URLRequest(url: u)
       webView.loadRequest(request)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

//扩展方法完成获取棋牌

extension EPMOAuthViewController: UIWebViewDelegate{
    
    //开始进行数据加载,HUD展示
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    //完成加载,HUD消失
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    //数据错误,HUD展示报错
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: "数据加载错误")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //获取请求的网址的字符串
        let urlString: String = request.url?.absoluteString ?? ""
        //查询token的标志
        let flag = "code="
        
        if urlString .contains(flag){
            
            //获取查询结果
            let quary = request.url?.query ?? ""
            
            let code = quary.substring(from: flag.endIndex)
          
            EPMUserAccountModelView.shared.loadAccesToken(code: code, finisedClouser: { (succes) in
                if !succes {
                    SVProgressHUD.show(withStatus: "世界上最遥远的地方是没有网络")
                    return
                }
                
               UIApplication.shared.keyWindow?.rootViewController = EPMWelcomViewController()
                
            })
            //获取结果后不再继续展示其余的结果
            return false
        }
        //不包含flag继续展示
        return true
        
    }
    
    
    
    
    
    
    
    
    
    
}
