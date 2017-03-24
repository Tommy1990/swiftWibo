//
//  EPMHomeViewModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import YYModel
class EPMHomeViewModel: NSObject {

   //MARKE: 定义数组
    var dataArray: [EPMHomeStatueViewModel] = [EPMHomeStatueViewModel]()
    
    //MARKE: 数据获取
    func getHomeViewData(finished:@escaping ((Bool)->())){
        
        EPMNetworkingTool.shearedTool.loadHomeData { (respond, error) in
            if  error != nil{
                finished(false)
                return
            }
            guard let res = respond as? [String: Any] else{
                finished(false)
                return
            }
            guard let resArr = res["statuses"] as? [[String: Any]] else{
                finished(false)
                return
            }
            let staueArr = NSArray.yy_modelArray(with: EPMHomeModel.self, json: resArr) as! [EPMHomeModel]
            
            var temArray: [EPMHomeStatueViewModel] = [EPMHomeStatueViewModel]()
            
            //MARKE: 遍历数组获得
            for model in staueArr{
                let statueModel:EPMHomeStatueViewModel = EPMHomeStatueViewModel()
                statueModel.homeModel = model
                temArray.append(statueModel)
            }
            //MARKE: 加载完成后处理
            self.dataArray = temArray
            finished(true)
        }
        
        
        
        
        
        
    }
    
    
    
    
}
