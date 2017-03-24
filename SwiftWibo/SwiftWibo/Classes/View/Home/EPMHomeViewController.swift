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
    
}


//MARKE: tabelView的相关操作
extension EPMHomeViewController{
     fileprivate func setupUI()  {
    tableView.register(EPMHomeTableViewCell.self, forCellReuseIdentifier: CELL_ID)
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200

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
        return cell
    }
}

//MARKE: 数据请求
extension EPMHomeViewController{
    
    fileprivate func loadData(){
        homeViewModel.getHomeViewData { (isSuccess) in
            if !isSuccess{
                print("加载失败")
                return
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    
}
