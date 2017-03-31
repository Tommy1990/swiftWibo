//
//  UIView+Extenssion.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/20.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

extension UILabel{
    
    convenience init(title:String,textColor:UIColor, fontSize: CGFloat){
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = 0
        self.sizeToFit()
    }
    
}

extension UIButton{
    convenience init(title:String ,textColor:UIColor,fontSize: CGFloat,backImage:String,imageName: String? = ""){
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setImage(UIImage.init(named:imageName!), for: .normal)
        self.setBackgroundImage(UIImage(named:backImage), for: .normal)
        self.sizeToFit()
    }
    
}

// 快速创建UIImageView
extension UIImageView{
    
    convenience init(imgName: String){
        self.init(image: UIImage(named: imgName))
    }
    
    /// 对SD进行封装
    ///
    /// - Parameters:
    ///   - urlString: 网络图片的地址
    ///   - placeholderImgName: 占位图片的名称
    func EPM_setImage(urlString: String?, placeholderImgName: String?){
        self.sd_setImage(with: URL(string: urlString ?? ""), placeholderImage: UIImage(named: placeholderImgName ?? ""))
    }
    
    
}

extension UIImage{
    
    class func getScreenSnap() ->UIImage?{
        let window  = UIApplication.shared.keyWindow
        UIGraphicsBeginImageContext(window!.bounds.size)
        window?.drawHierarchy(in: window!.bounds, afterScreenUpdates: false)
        let picture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return picture
    }
    func scaleImge(MAXWidth:CGFloat) -> UIImage{
        if self.size.width < MAXWidth{
            return self
        }
        let MAXHeight = self.size.height * MAXWidth / self.size.width
        let rect = CGRect(x: 0, y: 0, width: MAXWidth, height: MAXHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


