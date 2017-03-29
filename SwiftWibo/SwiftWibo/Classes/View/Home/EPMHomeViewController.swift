//
//  EPMHomeViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

 private let CELL_ID = "cell"
let homeViewModel = EPMHomeViewModel()
class EPMHomeViewController: EPMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let barBtn: UIBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(push))
        navigationItem.rightBarButtonItem = barBtn
        
        if !userLogIn {
            visitorView.resetUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
            //防止与正常的流程穿透
            return
        }
        
        setupUI()
        loadData()
    }
    @objc private func push(){
        
        let VC = EPMTestViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    fileprivate lazy var footView:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        view.color = ThemeColor
        return view
    }()
    
    fileprivate lazy var myRefreshControl: EPMRefreshControl = {
        let view:EPMRefreshControl = EPMRefreshControl()
        // 添加监听事件
        view.addTarget(self, action: #selector(refreshAction), for: UIControlEvents.valueChanged)
        return view
    }()
    
    fileprivate lazy var labRefreshTip:UILabel = {
        let label = UILabel(title:"加载", textColor: UIColor.white, fontSize: 15)
        label.frame = CGRect(x: 0, y:64-30, width: screenWidth, height: 30)
        label.backgroundColor = ThemeColor
        label.textColor = UIColor.white
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
}


//MARKE: tabelView的相关操作
extension EPMHomeViewController{
     fileprivate func setupUI()  {
    tableView.register(EPMHomeTableViewCell.self, forCellReuseIdentifier: CELL_ID)
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
    
    tableView.tableFooterView = footView
    tableView.separatorStyle = .none
    tableView.addSubview(myRefreshControl)
    self.navigationController?.view.insertSubview(labRefreshTip, belowSubview: (self.navigationController?.navigationBar)!)
//    labRefreshTip.isHidden = true

}
}
//MARKE: tabelView的数据源方法
extension EPMHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! EPMHomeTableViewCell
//        cell.backgroundColor = getRandomColor()
        cell.statusViewModel = homeViewModel.dataArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.dataArray.count-1 && !footView.isAnimating {
         footView.startAnimating()
         loadData()
        }
    }
    @objc fileprivate func refreshAction() {
        loadData()
    }
}

//MARKE: 数据请求
extension EPMHomeViewController{
    
    fileprivate func loadData(){
       
        homeViewModel.getHomeViewData(isPullUp: self.footView.isAnimating) { (isSuccess,count) in
            
           
            if !isSuccess{
                print("加载失败")
            }else{
                self.tableView.reloadData()
                if !self.footView.isAnimating{
                   self.showLabRefreshing(count: count)
                }
            }
            
             self.termingRefrshing()
            
           
        }
    }
    fileprivate func showLabRefreshing(count: Int){
        if self.labRefreshTip.isHidden == false{
            return
        }
        self.labRefreshTip.isHidden = false
        if count <= 0{
            labRefreshTip.text = "已经是最新的微博啦!"
        }else{
            labRefreshTip.text = "更新了\(count)条微博"
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.labRefreshTip.transform = CGAffineTransform(translationX: 0, y: 30)
        }) { (_) in
         
            UIView.animate(withDuration: 0.25, delay: 2, options: [], animations: { 
                self.labRefreshTip.transform = CGAffineTransform.identity
            }, completion: { (_) in
                self.labRefreshTip.isHidden = true
            })
        }
        
    }
    
    fileprivate func termingRefrshing() {
        self.myRefreshControl.endRefreshing()
        self.footView.stopAnimating()
    }
    
}
