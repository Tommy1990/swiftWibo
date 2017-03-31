//
//  EPMEmotionTool.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
let HMEMOTICONMAXCOL = 7
let HMEMOTICONMAXROW = 3
let HMEMOTICONMAXCOUNT = HMEMOTICONMAXCOL*HMEMOTICONMAXROW - 1
class EPMEmotionTool: NSObject {
 
    static let sheardTool = EPMEmotionTool()
    //存储路径
     fileprivate let file = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent("emoticon.archiver")
    
    lazy var emotionBundle : Bundle = {
       let path = Bundle.main.path(forResource: "Emoticons", ofType: "bundle")!
        return Bundle(path:path)!
    }()
    
    lazy var recntEmotion: [EPMEmotionModel] = {
       return self.decodeRectEmoj()
    }()
    
    lazy var normalEmotion: [EPMEmotionModel] = {
       return self.getEmotionsWithPlist(path: "default")
    }()
    
    lazy var mojiEmotion: [EPMEmotionModel] = {
        return self.getEmotionsWithPlist(path: "emoji")
    }()
    lazy var lxhEmotion: [EPMEmotionModel] = {
        return self.getEmotionsWithPlist(path: "lxh")
    }()
    
    
    lazy var allEmotions: [[[EPMEmotionModel]]] = {
       return [
        [self.recntEmotion],
        self.getEmoticonsGroup(emoticons: self.normalEmotion),
        self.getEmoticonsGroup(emoticons: self.mojiEmotion),
        self.getEmoticonsGroup(emoticons: self.lxhEmotion)
        
        ]
    }()

    func getEmoticonsGroup(emoticons:[EPMEmotionModel]) -> [[EPMEmotionModel]]{
        
        // 计算出当前每种表情要显示的页数
        let pageCount = (emoticons.count + HMEMOTICONMAXCOUNT - 1)/HMEMOTICONMAXCOUNT
        // 定义一个可变的数组
        var tempArray:[[EPMEmotionModel]] = [[EPMEmotionModel]]()
        // 遍历页数
        for i in 0..<pageCount{
            
            let location = HMEMOTICONMAXCOUNT*i
            var length = HMEMOTICONMAXCOUNT
            // 防止数组越界
            if location + length > emoticons.count {
                length = emoticons.count - location
            }
            // 范围
            let range = NSRange(location: location, length: length)
            // 通过range 截取对应的元素到一个数组中
            let array = (emoticons as NSArray).subarray(with: range) as! [EPMEmotionModel]
            // 保存一维数组
            tempArray.append(array)
        }
        // 返回二维数组
        return tempArray
    }

    
}
extension EPMEmotionTool{
    
    
    fileprivate func getEmotionsWithPlist(path:String) ->[EPMEmotionModel]{
        let file = emotionBundle.path(forResource: "\(path)/info.plist", ofType: nil)
        let array = NSArray(contentsOfFile: file!)!
        let tempArray = NSArray.yy_modelArray(with:EPMEmotionModel.self, json: array) as! [EPMEmotionModel]
        for emotionModel in tempArray{
            
            let png = emotionModel.png ?? ""
            emotionModel.allPath = path + "/" + png
        }
        return tempArray
    }
}
//数据归档/解档/默认数组添加
extension EPMEmotionTool{
    fileprivate func saveRecentEmoj(emojiModel:EPMEmotionModel) {
        for (i ,model) in recntEmotion.enumerated(){
            if emojiModel.isEmoji{
                if emojiModel.code == model.code{
                    recntEmotion.remove(at: i)
                }
            }else{
                if emojiModel.png == model.png{
                    recntEmotion.remove(at: i)
                }
            }
        }
        //插入新的元素
        recntEmotion.insert(emojiModel, at: 0)
        if (recntEmotion.count > 20){
            recntEmotion.removeLast()
        }
        //全路径赋值
        allEmotions[0][0] = recntEmotion
        //归档
        NSKeyedArchiver.archiveRootObject(recntEmotion, toFile: file)
    }
    
    fileprivate func decodeRectEmoj() -> [EPMEmotionModel]{
        
  if let reasult = NSKeyedUnarchiver.unarchiveObject(withFile: file) as? [EPMEmotionModel]{
        return reasult
    }
        return [EPMEmotionModel]()
    }
}

