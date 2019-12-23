//
//  ZLItemViewController.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLItemViewController: ZLBaseTableViewController {

    var model: ZLCircularModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
    }
    
    func initData() {
        vm.model = model
    }
    
    func initUI() {
        setRightBarButtonItem(name: "nav_done", type: .image) {
            
        }
        
        tableView.tableHeaderView = headView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    lazy var headView: ZLItemHeadView = {
        let temp = ZLItemHeadView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: autoSize(number: 50)))
        temp.backgroundColor = color_ffffff
        return temp
    }()
    
    lazy var vm: ZLItemViewModel = ZLItemViewModel()
    
}

extension ZLItemViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.model?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.model?.items[indexPath.row].title
        return cell
    }
}
