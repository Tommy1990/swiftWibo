//
//  EPMComposePictureView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/29.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
fileprivate let sizeMargin:CGFloat = 5.0
fileprivate let itemWH = (screenWidth - 2*margine - 2 * sizeMargin)/3
class EPMComposePictureView: UICollectionView {
    var imgList:[UIImage] = [UIImage]()
    func addImg(img:UIImage){
        imgList.append(img)
        reloadData()
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWH, height: itemWH)
        flowLayout.minimumLineSpacing = sizeMargin
        flowLayout.minimumInteritemSpacing = sizeMargin
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        backgroundColor = UIColor.lightGray
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        dataSource = self
        delegate = self
    }
    
}
extension EPMComposePictureView: UICollectionViewDataSource,UICollectionViewDelegate {
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}


