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
    
    fileprivate lazy var EPMRefreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: "加载中请稍后")
        // 添加监听事件
        view.addTarget(self, action: #selector(refreshAction), for: UIControlEvents.valueChanged)
        return view
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
    tableView.addSubview(EPMRefreshControl)
        

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
       
        homeViewModel.getHomeViewData(isPullUp: self.footView.isAnimating) { (isSuccess) in
            //加载控件动画停止
            self.termingRefrshing()
            if !isSuccess{
                print("加载失败")
                return
            }
            
            self.tableView.reloadData()
        }
    }
    
    fileprivate func termingRefrshing() {
        self.EPMRefreshControl.endRefreshing()
        self.footView.stopAnimating()
    }
    
}
