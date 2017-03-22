//
//  EPMBaseViewController.swift
//  SwiftWibo
//
//  Created by 马继鵬 on 17/3/19.
//  Copyright © 2017年 7TH. All rights reserved.
//

import UIKit

class EPMBaseViewController: UITableViewController,EPMVistorDelegate {
    
    var userLogIn = false
   lazy var visitorView = EPMVistorView(frame: UIScreen.main.bounds)
    override func loadView() {
        if userLogIn{
            super.loadView()
        }
        self.view = visitorView
        visitorView.delegate = self
    }
    
    func userLogingClick(visitorView: EPMVistorView) {
        
        let controller: EPMOAuthViewController = EPMOAuthViewController()
        let nav = UINavigationController(rootViewController: controller)
        //跳转到 导航控制器
        self.present(nav, animated: true, completion: nil)
        
        
    }
    func userRegisterClick(visitorView: EPMVistorView) {
        print("\(visitorView)点击了注册按钮")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
}
