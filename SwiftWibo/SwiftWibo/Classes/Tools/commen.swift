//
//  commen.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/22.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

//MARKE:开发者信息
let client_id = "1130717009"

let redirect_uri = "http://www.itheima.com"

let client_secret = "65cb70a5820fcb3a7e199ce9043ac674"

//设置通知

let SWITCHROOTCONTROLLERINFO = "switchRootControllerInfo"

//设置随机颜色
func getRandomColor()->UIColor{
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    
    
    return UIColor(displayP3Red: r/255, green: g/255, blue: b/255, alpha: 1.0);
}

//MARKE: 定义公共属性
let margine = CGFloat(10)
//MARKE: 定义字体大小
let FONTSIZEOFSMALL: CGFloat = 10
let FONTSIZEOFNORMAL: CGFloat = 14
let FONTSIZEOFBIG: CGFloat = 18
//MARKE: 定义主题颜色
let ThemeColor = UIColor.orange
//MAKE:定义屏幕宽度
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height



