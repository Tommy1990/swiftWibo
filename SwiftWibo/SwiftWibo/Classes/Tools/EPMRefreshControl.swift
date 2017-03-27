//
//  EPMRefreshControl.swift
//  0327刷新控件
//
//  Created by 马继鵬 on 17/3/27.
//  Copyright © 2017年 TOM. All rights reserved.
//

import UIKit

enum EPMRefrashType:String {
    case normal = "正常中"
    case pulling = "下拉中"
    case refreshing = "刷新中"
}
private let refreshControlH:CGFloat = 50
class EPMRefreshControl: UIControl {

    fileprivate var scrollView: UIScrollView?
    fileprivate var refreshControlTye:EPMRefrashType? = .normal{
        didSet{
            labTitle.text = refreshControlTye?.rawValue
            
            switch refreshControlTye! {
            case .normal:
                if oldValue == .refreshing{
                    UIView.animate(withDuration: 0.25, animations: { 
                        self.scrollView?.contentInset.top -= refreshControlH
                    }, completion: { (_) in
                        self.imgIndictor.stopAnimating()
                        self.imgArrow.isHidden = false
                    })
                    
                }
                UIView.animate(withDuration: 0.25, animations: {
                    self.imgArrow.transform = CGAffineTransform.identity
                })
            case  .pulling:
               UIView.animate(withDuration: 0.25, animations: { 
                self.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(-3*M_PI))
               })
                
            case .refreshing:
                UIView.animate(withDuration: 0.25, animations: { 
                    self.scrollView?.contentInset.top += refreshControlH
                    self.imgArrow.isHidden = true
                     self.imgIndictor.startAnimating()
                }, completion: { (_) in
                   self.sendActions(for: .valueChanged)
                })
            }
        }
    }
    
    func endRefreshing() {
        refreshControlTye = .normal
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: -refreshControlH, width: UIScreen.main.bounds.width, height: refreshControlH))
        setupUI()
    }
    //MARKE: 设置UI
    private func setupUI(){
        self.backgroundColor = UIColor.orange
        addSubview(labTitle)
        addSubview(imgArrow)
        addSubview(imgIndictor)
        
        
        //布局
        labTitle.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: labTitle, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labTitle, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        imgArrow.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: imgArrow, attribute: .trailing, relatedBy: .equal, toItem: labTitle, attribute: .leading, multiplier: 1, constant: -7))
        addConstraint(NSLayoutConstraint(item: imgArrow, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        imgIndictor.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: imgIndictor, attribute: .trailing, relatedBy: .equal, toItem: labTitle, attribute: .leading, multiplier: 1, constant:-7))
        addConstraint(NSLayoutConstraint(item: imgIndictor, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
      
    }
    
    
    //懒加载控件
    private lazy var labTitle:UILabel = {
        let label = UILabel()
        label.text = "正常中"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var imgArrow:UIImageView = {
        let img = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
        
        return img
    }()
    
    private lazy var imgIndictor:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARKE: 监听方法

extension EPMRefreshControl {
    
    override func  willMove(toSuperview newSuperview: UIView?) {
        guard let view = newSuperview as? UIScrollView else {
            return
        }
        scrollView = view
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    //监听事件
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let contentOffsetMaxY = -((self.scrollView?.contentInset.top)! + refreshControlH)
        let contentOffsetY = scrollView!.contentOffset.y
        if scrollView!.isDragging {
        if contentOffsetY >= contentOffsetMaxY && refreshControlTye == .pulling{
            refreshControlTye = .normal
            
        }else if contentOffsetY < contentOffsetMaxY && refreshControlTye == .normal {
            refreshControlTye = .pulling
        }
        
        }else{
            if refreshControlTye == .pulling{
                refreshControlTye = .refreshing
            }
        }
    }
    
    
    
}

