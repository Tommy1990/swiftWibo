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
    
    private  convenience init()
    {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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