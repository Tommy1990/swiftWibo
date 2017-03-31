//
//  EPMEmotionPageView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEmotionPageView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayOut = UICollectionViewFlowLayout()
        flowLayOut.itemSize = CGSize(width: screenWidth, height: 216 - 35)
        // 垂直和水平间距
        flowLayOut.minimumLineSpacing = 0
        flowLayOut.minimumInteritemSpacing = 0
        // 滚动方向
        flowLayOut.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: flowLayOut)
         setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    fileprivate func setupUI(){
        
        dataSource = self
       register(EPMEmotionPageCell.self, forCellWithReuseIdentifier: "cell")
    }
}
extension EPMEmotionPageView:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return EPMEmotionTool.sheardTool.allEmotions.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EPMEmotionTool.sheardTool.allEmotions[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EPMEmotionPageCell
         backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
//        cell.backgroundColor = getRandomColor()
        cell.emoticons = EPMEmotionTool.sheardTool.allEmotions[indexPath.section][indexPath.item]
        cell.indexpath = indexPath
        return cell
        
    }
    
}
