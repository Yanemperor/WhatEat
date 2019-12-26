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
        if model == nil {
            let tempModel = ZLCircularModel()
            tempModel.id = (ZLDataBase.shared.getCircularTable()?.last?.id ?? 2) + 1
            vm.model = tempModel
        }else{
            vm.model = model
        }
        vm.isHiddenPolishing = model?.type ?? true
    }
    
    func initUI() {
        navTitle(title: "选项")
        setRightBarButtonItem(name: "nav_done", type: .image) {
            if !self.vm.isSave() {
                return
            }
            self.vm.saveDB()
            if self.backBlock != nil {
                self.backBlock!(self.vm.model?.id ?? 0)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = autoSize(number: 50)
        tableView.register(ZLItemTitleCell.self, forCellReuseIdentifier: "ZLItemTitleCell")
        tableView.register(ZLItemViewCell.self, forCellReuseIdentifier: "ZLItemViewCell")
        tableView.register(ZLItemFooterCell.self, forCellReuseIdentifier: "ZLItemFooterCell")
        
    }
    
    lazy var vm: ZLItemViewModel = ZLItemViewModel()
    
}

extension ZLItemViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2{
            return 1
        }
        return self.vm.model?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ZLItemTitleCell = tableView.dequeueReusableCell(withIdentifier: "ZLItemTitleCell", for: indexPath) as! ZLItemTitleCell
            cell.model = self.vm.model
            cell.selectionStyle = .none
            cell.divideBlock = { on in
                self.vm.isOpenDivide(on: on)
                tableView.reloadData()
            }
            return cell
        }else if indexPath.section == 2 {
            let cell: ZLItemFooterCell = tableView.dequeueReusableCell(withIdentifier: "ZLItemFooterCell", for: indexPath) as! ZLItemFooterCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell: ZLItemViewCell = tableView.dequeueReusableCell(withIdentifier: "ZLItemViewCell", for: indexPath) as! ZLItemViewCell
            cell.model = self.vm.model?.items[indexPath.row]
            cell.isHiddenPolishing(hidden: self.vm.isHiddenPolishing)
            cell.delBlock = { model in
                self.vm.removeItemData(model: model)
                tableView.reloadData()
            }
            cell.polishingBlock = { model in
                self.vm.polishingItemData(model: model)
                tableView.reloadData()
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let tempModel = ZLCircularItemModel()
            self.vm.model?.items.append(tempModel)
            self.vm.divideProbability()
            tableView.reloadData()
        }
    }
}
