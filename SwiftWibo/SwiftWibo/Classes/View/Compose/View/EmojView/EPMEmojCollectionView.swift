//
//  EPMEmojCollectionView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEmojCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayOut = UICollectionViewFlowLayout()
        
        super.init(frame: frame, collectionViewLayout: flowLayOut)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        
        
        
    }
}
