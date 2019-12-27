//
//  ZLRecommendedViewController.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/27.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLRecommendedViewController: ZLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        navTitle(title: "推荐")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = autoSize(number: 50)
        tableView.register(ZLSetCell.self, forCellReuseIdentifier: "ZLSetCell")
    }
    
    // MARK: - View(页面处理)
    
    
    
    // MARK: - 对外接口
    
    
    // MARK: - private methods(内部接口)
    
    
    // MARK: - loading
    
    
    // MARK: - 懒加载
    lazy var vm: ZLRecommendedViewModel = ZLRecommendedViewModel()
    
}

extension ZLRecommendedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return vm.titles.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell: ZLSetCell = tableView.dequeueReusableCell(withIdentifier: "ZLSetCell", for: indexPath) as! ZLSetCell
           cell.selectionStyle = .none
           cell.setTitle(title: vm.titles[indexPath.row])
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let title = vm.titles[indexPath.row]
           if title == "成考宝典" {
                let urlString = "itms-apps://itunes.apple.com/app/" + "1484750167"
                if let url = URL(string: urlString) {
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
       }
}
