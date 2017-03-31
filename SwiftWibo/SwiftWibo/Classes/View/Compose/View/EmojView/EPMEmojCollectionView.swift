//
//  EPMEmojCollectionView.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/30.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMEmojCollectionView: UIView {

    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(bottomBtnView)
        addSubview(emotionPageView)
        addSubview(pageControl)
        
        bottomBtnView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(35)
        }
       
        emotionPageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self)
            make.bottom.equalTo(bottomBtnView.snp.top)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(emotionPageView).offset(10)
        }
        
        bottomBtnView.closure = {[weak self] type ->() in
            let indexpath = IndexPath(item: 0, section: type.rawValue - 2000)
            self?.emotionPageView.scrollToItem(at: indexpath, at: .left, animated: false)
        }
        
        
       let indexPath = IndexPath(item: 0, section: 1)
        DispatchQueue.main.async {
            self.emotionPageView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
        
        
    }
    fileprivate lazy var bottomBtnView:EPMbottombtnView = EPMbottombtnView()
    fileprivate lazy var emotionPageView: EPMEmotionPageView = {
       let view = EPMEmotionPageView()
        view.isPagingEnabled = true
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    // 指示器
    fileprivate lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.isUserInteractionEnabled = false
        view.currentPage = 1
        view.numberOfPages = 4
        // 选中
        view.setValue(UIImage(named:"compose_keyboard_dot_selected"), forKey: "currentPageImage")
        // 默认
        view.setValue(UIImage(named:"compose_keyboard_dot_normal"), forKey: "pageImage")
        return view
    }()

}
extension EPMEmojCollectionView: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = screenWidth * 0.5 + scrollView.contentOffset.x
        
        let center = CGPoint(x: centerX, y: 0)
        //通过cell上的一点获得Cell
        if let index = emotionPageView.indexPathForItem(at: center)  {
            bottomBtnView.setCurrentButton(index: index.section)
            pageControl.currentPage = index.item == 1 ? 0 : index.item
            pageControl.numberOfPages = EPMEmotionTool.sheardTool.allEmotions[index.section].count
        }
        
        
        
    }
}
