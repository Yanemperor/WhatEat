//
//  ZLSetViewController.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import StoreKit

class ZLSetViewController: ZLBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        navTitle(title: "设置")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = autoSize(number: 50)
        tableView.register(ZLSetCell.self, forCellReuseIdentifier: "ZLSetCell")
    }
    
    // MARK: - View(页面处理)
    
    
    
    // MARK: - 对外接口
    
    
    // MARK: - private methods(内部接口)
    func shareAction() {
        let url = "https://apps.apple.com/cn/app/%E6%88%90%E8%80%83%E5%AE%9D%E5%85%B8/id1491874274"
        ZLSystemShare.manager.share(shreVC: self, title: "吃啥呀？", shareUrl: URL(string: url))
    }
    
    // MARK: - loading
    
    
    // MARK: - 懒加载
    lazy var vm: ZLSetViewModel = ZLSetViewModel()


}

extension ZLSetViewController {
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
        if title == "给个评分" {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                // Fallback on earlier versions
            }
        }else if title == "分享" {
            shareAction()
        }else if title == "推荐" {
            let vc = ZLRecommendedViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        else if title == "关于我" {
            let vc = ZLAboutViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
 
    }
}
