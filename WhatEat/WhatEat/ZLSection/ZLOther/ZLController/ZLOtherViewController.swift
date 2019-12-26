//
//  ZLOtherViewController.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLOtherViewController: ZLBaseTableViewController {

    typealias BackBlock = (ZLCircularModel) -> ()
    
    var backBlock: BackBlock?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    
    func initUI() {
        navTitle(title: "其他")
        setRightBarButtonItem(name: "other_add", type: .image) {
            let vc = ZLItemViewController()
            vc.backBlock = { id in
                self.vm.getCirculars()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.rowHeight = autoSize(number: 50)
        tableView.register(ZLOtherCell.self, forCellReuseIdentifier: "ZLOtherCell")
    }
    
    func initData() {
        vm.getCirculars()
        vm.reloadBlock = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View(页面处理)
    
    
    // MARK: - 对外接口
    
    
    // MARK: - private methods(内部接口)
    
    
    // MARK: - loading
    
    
    // MARK: - 懒加载
    lazy var vm: ZLOtherViewModel = ZLOtherViewModel()


}

extension ZLOtherViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.allCircularModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZLOtherCell = tableView.dequeueReusableCell(withIdentifier: "ZLOtherCell", for: indexPath) as! ZLOtherCell
        cell.model = self.vm.allCircularModels[indexPath.row]
        cell.editBlock = { model in
            let vc = ZLItemViewController()
            let tempModel: ZLCircularModel = ZLCircularModel.deserialize(from: model.toJSONString()) ?? ZLCircularModel()
            vc.model = tempModel
            vc.backBlock = { id in
                self.vm.getCirculars()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.backBlock != nil {
            self.backBlock!(self.vm.allCircularModels[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.vm.removeModel(model: self.vm.allCircularModels[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
