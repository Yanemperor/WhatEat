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
    typealias BackBlock = (Int) -> ()
    var backBlock: BackBlock?

    
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
            self.vm.saveDB()
            if self.backBlock != nil {
                self.backBlock!(self.vm.model?.id ?? 0)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
//        tableView.tableHeaderView = headView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = autoSize(number: 50)
        tableView.register(ZLItemTitleCell.self, forCellReuseIdentifier: "ZLItemTitleCell")
        tableView.register(ZLItemViewCell.self, forCellReuseIdentifier: "ZLItemViewCell")
    }
    
    lazy var headView: ZLItemHeadView = {
        let temp = ZLItemHeadView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: autoSize(number: 50)))
        temp.backgroundColor = color_ffffff
        return temp
    }()
    
    lazy var vm: ZLItemViewModel = ZLItemViewModel()
    
}

extension ZLItemViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.vm.model?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ZLItemTitleCell = tableView.dequeueReusableCell(withIdentifier: "ZLItemTitleCell", for: indexPath) as! ZLItemTitleCell
            cell.model = self.vm.model
            return cell
        }else{
            let cell: ZLItemViewCell = tableView.dequeueReusableCell(withIdentifier: "ZLItemViewCell", for: indexPath) as! ZLItemViewCell
            cell.model = self.vm.model?.items[indexPath.row]
            return cell
        }
    }
}
