//
//  EPMHomeStatueViewModel.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import YYText
//MARKE: 完成图片类的加载
class EPMHomeStatueViewModel: NSObject {
//MARKE: 生成HomeModel的属性
    var homeModel:EPMHomeModel? {
        didSet{
            MbrankImg = self.dealMbrankImage(mbrank: (homeModel?.user?.mbrank ?? 0))
            verifiedImg = self.dealVerifiedImage(verified: homeModel?.user?.verified ?? 0)
            sourceText = self.getWeiBoSource(source: homeModel?.source ?? "")
            //展示富文本
            oringinalContext = self.dealContentAttributedString(text: homeModel?.text)
            retweetContext = self.dealContentAttributedString(text: homeModel?.retweeted_status?.text)
            
        }
    }
    
    override init() {
        super.init()
    }
    var MbrankImg: UIImage?
    var verifiedImg: UIImage?
    var sourceText: String?
    var timeText: String? {
        return getFormateDate(Creatdate: homeModel?.created_at)
    }
    var oringinalContext:NSAttributedString?
    var retweetContext:NSAttributedString?
    
}
//MARKE: 加载会员等级图片
extension EPMHomeStatueViewModel{
    func  dealMbrankImage(mbrank: Int)->UIImage?  {
        if mbrank>0 && mbrank<7{
            return  UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return UIImage(named: "common_icon_membership")
    }
}

//MARKE: 加载认证图片
extension EPMHomeStatueViewModel{
    func dealVerifiedImage(verified: Int) -> UIImage?{
        switch verified {
        case 1:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return UIImage(named: "avatar_vgirl")
        }
    }
}
//MARKE: 微博来源

extension EPMHomeStatueViewModel {
    
   fileprivate func getWeiBoSource(source: String?) -> String?{
        
    guard let src = source, src.contains("\">") else{
       return "来自 那遥远的地方"
    }
    
    //获取设备
    let startIndex = src.range(of: "\">")
    let endIndex = src.range(of: "</")
    let res = src.substring(with: startIndex!.upperBound..<endIndex!.lowerBound)
    
    return "来自 " + res

    }
}

//MARKE: 获取时间
extension EPMHomeStatueViewModel{
    fileprivate func getFormateDate(Creatdate:Date?) ->String?{
        guard let sinaDate = Creatdate else{
            return nil
        }
        let df = DateFormatter()
        let isThisYear = judegeIsThisYear(date: sinaDate)
            
        if isThisYear{
            let canclender = Calendar.current
            if canclender.isDateInToday(sinaDate){
                let s = Int(Date().timeIntervalSince(sinaDate))
                if s < 60{
                   return "刚刚"
                }else if s > 60 && s < 3600{
                   return "\(s/60)分钟前"
                }else {
                    return "\(s / 3600)小时前"
                }
                
                
            }else if canclender.isDateInYesterday(sinaDate){
                df.dateFormat = "昨天  hh:mm"
            }else{
            
            }
        
        }else{
            df.dateFormat = "yyyy年MM月dd日 hh:mm"
        }
        return df.string(from: sinaDate)
    }
    
    
    private func judegeIsThisYear(date:Date) -> Bool{
    let df = DateFormatter()
    df.dateFormat = "yyyy"
    let sinaDate = df.string(from: date)
        
    return  sinaDate == df.string(from: Date())
    }
    
}
//MARKE:
extension EPMHomeStatueViewModel{
   //获取文字
    fileprivate func dealContentAttributedString(text:String?) -> NSAttributedString?{
        guard let t = text else {
            return nil
        }
        let allAttribute = NSMutableAttributedString(string: t)
        let  reasult = try! NSRegularExpression(pattern: "\\[\\w+\\]", options: []).matches(in: t, options: [], range: NSRange(location: 0, length: t.characters.count))
        for match in reasult.reversed() {
            let res = (t as NSString).substring(with: match.range)
            let model = EPMEmotionTool.sheardTool.getEmoticonModelWithEmoticons(chs: res)
            let allPath = model?.allPath ?? ""
            
            guard let img = UIImage(named: allPath, in: EPMEmotionTool.sheardTool.emotionBundle, compatibleWith: nil) else{
                continue
            }
            
            let attr = NSMutableAttributedString.yy_attachmentString(withEmojiImage: img, fontSize: FONTSIZEOFNORMAL)!
            allAttribute.replaceCharacters(in: match.range, with: attr)
            
        }
        //匹配用户
        setTextHighlight(pattern: "@[a-zA-Z0-9\\u4e00-\\u9fa5_\\-]+", allAttributedString: allAttribute)
        // //匹配话题：#[^#]+#
        setTextHighlight(pattern: "#[^#]+#", allAttributedString: allAttribute)
         // 设置富文本字体大小
        allAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: FONTSIZEOFNORMAL), range: NSRange(location: 0, length: allAttribute.string.characters.count))
        
        return allAttribute;
    }
    
    
    //MARKE: 文字高亮处理
    fileprivate func  setTextHighlight(pattern: String, allAttributedString: NSMutableAttributedString){
        let matchReasult = try! NSRegularExpression(pattern: pattern, options: []).matches(in: allAttributedString.string, options: [], range:NSRange(location:0, length: allAttributedString.string.characters.count))
        
        let border = YYTextBorder(fill: UIColor.gray, cornerRadius: 3)
        border.insets = UIEdgeInsetsMake(1, 0, 0, 0)
        let highLight = YYTextHighlight()
        highLight.setColor(UIColor.white)
        highLight.setBackgroundBorder(border)
        
        for match in matchReasult {
            allAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: match.range)
            allAttributedString.yy_setTextHighlight(highLight, range: match.range)
        }
    
    }
    
}


