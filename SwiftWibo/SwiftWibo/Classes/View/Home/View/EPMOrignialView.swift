//
//  EPMOrignialView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/24.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMOrignialView: UIView {

    override init(frame:CGRect){
        super.init(frame:frame)
        self.backgroundColor = getRandomColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
