//
//  EPMPictureView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/25.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

private let Cell_ID = "Cell_ID"
class EPMPictureView: UICollectionView {
    fileprivate let layOut = UICollectionViewFlowLayout()
    fileprivate let sizeWH = 5.0
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layOut)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARKE: 设置UI
    private func setupUI() {
       dataSource = self
        
    register(UICollectionViewCell.self, forCellWithReuseIdentifier: Cell_ID)
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
    }
    
}
extension EPMPictureView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell_ID, for: indexPath)
        cell.backgroundColor = getRandomColor()
        return cell
    }
    
    
}
