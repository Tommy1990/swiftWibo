//
//  EPMNetworkingTool.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/22.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import AFNetworking
enum HTTPMethod: Int {
    case GET = 0
    case POST
}


class EPMNetworkingTool: AFHTTPSessionManager {

    //创建单例对象
    static let shearedTool:EPMNetworkingTool = {
        let tool = EPMNetworkingTool()
        //扩展解析类型
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tool
    }()
    
   
    
   
    func request(method:HTTPMethod ,urlString: String, paramter: Any, finished:@escaping ((Any?,Error?)->())){
        
        let successClouser = { (task:URLSessionTask ,respond:Any?) -> () in
            
            finished(respond,nil)
        }
        
        let failedClouser = { (task: URLSessionTask?, error:Error) ->() in
            finished(nil,error)
        }
        
        if method == .GET {
            get(urlString, parameters: paramter, progress: nil, success: successClouser, failure: failedClouser)
        }else{
            post(urlString, parameters: paramter, progress: nil, success: successClouser, failure: failedClouser)
            
        }
        
    }
    

}
//MARKE: homeView加载网络数据
extension EPMNetworkingTool{
    
    func loadHomeData(since_id: Int64, max_id: Int64,finished:@escaping ((Any?,Error?)->()))  {
        //请求地址
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //请求参数
        let para = ["access_token":EPMUserAccountModelView.shared.token,
                    "since_id":"\(since_id)",
                    "max_id":"\(max_id)"
                    ]
        
        self.request(method: .GET, urlString: urlString, paramter: para, finished: finished)
        
}
}
//MARKE: 发微博方法
extension EPMNetworkingTool{
    
    //纯文字
    func senderWeibo(status: String?,finished:@escaping (Any?, Error?)->()) {
        let urlString:String = "https://api.weibo.com/2/statuses/update.json"
        let para = [
                    "access_token":EPMUserAccountModelView.shared.token,
                    "status":status ?? ""
                    ]
        request(method: .POST, urlString: urlString, paramter: para, finished: finished)
        
    }
    //含图片
    func sendWeibo(status:String?,imgList:[UIImage],finished:@escaping (Any?, Error?)->()){
        let urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
        let para = [
                "access_token":EPMUserAccountModelView.shared.token,
                "status":status ?? ""
                    ]
        post(urlString, parameters: para, constructingBodyWith: { (formData) in
            
            for img in imgList{
                let data = UIImagePNGRepresentation(img)
                guard let d = data  else{
                    return
                }
                formData.appendPart(withFileData: d, name: "pic", fileName: "suisui", mimeType: "application/actet-stream")
            }
            
            
            
        }, progress: nil, success: { (_, res) in
            finished(res,nil)
        }) { (_, error) in
            finished(nil,error)
        }
    }
    
}
