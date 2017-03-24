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
    
    func loadHomeData(finished:@escaping ((Any?,Error?)->()))  {
        //请求地址
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //请求参数
        let para = ["access_token":EPMUserAccountModelView.shared.token]
        
        self.request(method: .GET, urlString: urlString, paramter: para, finished: finished)
        
}
}
