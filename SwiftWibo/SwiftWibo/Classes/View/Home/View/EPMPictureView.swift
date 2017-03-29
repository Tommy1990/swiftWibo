//
//  EPMPictureView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/25.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit
import SDWebImage

private let Cell_ID = "Cell_ID"

fileprivate let sizeMargin:CGFloat = 5.0
fileprivate let itemWH = (screenWidth - 2*margine - 2 * sizeMargin)/3
class EPMPictureView: UICollectionView {
    
    
    var pic_urls:[EPMPictureUrlModel]? {
        didSet{
     
        let size = dealPictureViewSize(count: pic_urls!.count )
        
        self.snp.updateConstraints { (make) in
            make.size.equalTo(size)
        }
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
            
            if pic_urls?.count == 1{
               layout.itemSize = size
            }else{
                layout.itemSize = CGSize(width: itemWH, height: itemWH)
            }
            
            layoutIfNeeded()
            reloadData()
        }
        
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
    //MARKE: 设置UI
    private func setupUI() {
       dataSource = self
    self.backgroundColor = UIColor.clear
    register(EPMPictureviewCell.self, forCellWithReuseIdentifier: Cell_ID)
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
    //MARKE: 设置图片的大小
    private func dealPictureViewSize(count:Int)-> CGSize{
        
        if count == 1 {
            
           if let thumbnail_pic = pic_urls?.first?.thumbnail_pic {
             let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: thumbnail_pic)
            
            if let img = image {
                let W = img.size.width < 80 ? 80 : img.size.width
                let H = img.size.height > 150 ? 150 : img.size.height
                
                return CGSize(width: W, height: H)
                
            }
            }
        }
        let row = count == 4 ? 2 : (count - 1)/3 + 1
        let col = count == 4 ? 2 : count >= 3 ? 3 : count
        let W = CGFloat(col) * itemWH + CGFloat(col - 1)*sizeMargin
        let H = CGFloat(row) * itemWH + CGFloat(row - 1)*sizeMargin
        return CGSize(width: W, height: H)

    }
    
    
}
extension EPMPictureView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic_urls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell_ID, for: indexPath) as!EPMPictureviewCell
        cell.pictureModel = pic_urls![indexPath.item]
        return cell
    }
    
    
}

class EPMPictureviewCell: UICollectionViewCell {
    
    var pictureModel:EPMPictureUrlModel?{
        didSet{
            imgPicture.EPM_setImage(urlString: pictureModel?.thumbnail_pic, placeholderImgName: "avatar_default_big")
            if let thumbnail_pic = pictureModel?.thumbnail_pic,thumbnail_pic.hasSuffix(".gif") {
                gifImageView.isHidden = false
            }else{
                gifImageView.isHidden = true
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
    //设置UI
    private func setupUI() {
        contentView.addSubview(imgPicture)
        contentView.addSubview(gifImageView)
        
        imgPicture.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        gifImageView.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(imgPicture)
        }
    }
    
   private lazy var imgPicture: UIImageView = {
        let img = UIImageView(imgName: "avatar_default_big")
        // 设置图片填充方式
        img.contentMode = .scaleAspectFill
        // 超出部分不显示
        img.clipsToBounds = true
        return img
    }()

   private lazy var gifImageView: UIImageView = UIImageView(imgName: "timeline_image_gif")
}
