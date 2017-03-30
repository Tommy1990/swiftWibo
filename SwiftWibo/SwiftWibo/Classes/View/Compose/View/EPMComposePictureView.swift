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
    var closure:(()->())?
    
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
        register(EPMComposeCollectionView.self, forCellWithReuseIdentifier: "cell")
        dataSource = self
        delegate = self
    }
    
}
extension EPMComposePictureView: UICollectionViewDataSource,UICollectionViewDelegate {
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let s = imgList.count
        if s == 0 || s == 9{
            return s
        }else{
            return s+1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EPMComposeCollectionView
        if indexPath.item == imgList.count{
            cell.img = nil
        }else{
            cell.img = imgList[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.item == imgList.count{
            closure!()
        }
        
    }
}

class EPMComposeCollectionView: UICollectionViewCell {
    
    var img:UIImage?{
        didSet{
            if img == nil{
                imgView.image = UIImage(named: "compose_pic_add")
                imgView.highlightedImage = UIImage(named:"compose_pic_add_highlighted")
            }else{
                imgView.image = img
                imgView.highlightedImage = nil
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI()
    {
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    private lazy var imgView:UIImageView = UIImageView()
}


