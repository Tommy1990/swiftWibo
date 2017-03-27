//
//  EPMHomeViewModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import YYModel
import SDWebImage
class EPMHomeViewModel: NSObject {

   //MARKE: 定义数组
    var dataArray: [EPMHomeStatueViewModel] = [EPMHomeStatueViewModel]()
    
    //MARKE: 数据获取
    func getHomeViewData(isPullUp:Bool,finished:@escaping ((Bool,Int)->())){
        var sinceId:Int64 = 0
        var maxId:Int64 = 0
        if isPullUp {
            maxId = dataArray.last?.homeModel?.id ?? 0
            if maxId > 0 {
                maxId -= 1
            }
        }else{
            sinceId = dataArray.first?.homeModel?.id ?? 0
        }
        
        
        
        EPMNetworkingTool.shearedTool.loadHomeData(since_id: sinceId, max_id: maxId) { (respond, error) in
            if  error != nil{
                finished(false,0)
                return
            }
            guard let res = respond as? [String: Any] else{
                finished(false,0)
                return
            }
            guard let resArr = res["statuses"] as? [[String: Any]] else{
                finished(false,0)
                return
            }
            let staueArr = NSArray.yy_modelArray(with: EPMHomeModel.self, json: resArr) as! [EPMHomeModel]
            
//              print(resArr)
            var temArray: [EPMHomeStatueViewModel] = [EPMHomeStatueViewModel]()
            
            //MARKE: 遍历数组获得
            for model in staueArr{
                let statueModel:EPMHomeStatueViewModel = EPMHomeStatueViewModel()
                statueModel.homeModel = model
                temArray.append(statueModel)
            }
           self.downLoadSingleImage(tempArray: temArray, finish: finished)
            
            //MARKE: 加载完成后处理
            if isPullUp {
                 self.dataArray = self.dataArray + temArray
            }else{
                 self.dataArray = temArray + self.dataArray
            }
                
            
           
            
        }
    }
    
    private func downLoadSingleImage(tempArray:[EPMHomeStatueViewModel],finish:@escaping (Bool,Int)->()) {
        //创建线程管理
        let  group = DispatchGroup()
        
        for statueView in tempArray{
            
            if statueView.homeModel?.pic_urls?.count == 1{
                //任务开始标记
                group.enter()
                SDWebImageManager.shared().downloadImage(with: URL(string:statueView.homeModel?.pic_urls?.last?.thumbnail_pic ?? ""), options: [], progress: nil, completed: { (image, error, _, _, _) in
                    group.leave()
                })
                
            }
            
            if statueView.homeModel?.retweeted_status?.pic_urls?.count == 1{
                group.enter()
                SDWebImageManager.shared().downloadImage(with: URL(string:statueView.homeModel?.retweeted_status?.pic_urls?.last?.thumbnail_pic ?? ""), options: [], progress: nil, completed: { (image, error, _, _, _) in
                    group.leave()
                })
                
                group.notify(queue: DispatchQueue.main){
                    finish(true,tempArray.count)
                }
                
            }
            
        }
    
    }
    
}
