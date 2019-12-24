//
//  ZLCircularViewModel.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLCircularViewModel: ZLBaseViewModel {
    typealias ReloadBlock = () -> ()
    var reloadBlock: ReloadBlock?

    var circularModel: ZLCircularModel?
    var itemTitle: Array<String> = ["火锅","炒菜","饺子","炒饭","粥","面条"]
    
    
    func getCircular() {
        let temp: Array<ZLCircularModel> = ZLDataBase.shared.getCircularTable() ?? []
        if temp.count > 0 {
            circularModel = temp[0]
        }else{
            circularModel = getInitCircularModel()
            ZLDataBase.shared.insertCircularTable(array: [circularModel!])
        }
        reload()
    }
    
    func getCircular(id: Int) {
        let temp: ZLCircularModel = ZLDataBase.shared.getCircularTable(id: id)!
        circularModel = temp
        reload()
    }
    
    func getInitCircularModel() -> ZLCircularModel {
        let model = ZLCircularModel()
        model.title = "吃啥呀？"
        model.type = 1
        model.id = 1
        var items: Array<ZLCircularItemModel> = []
        for itemTitle in itemTitle {
            let item: ZLCircularItemModel = ZLCircularItemModel()
            item.title = itemTitle
            item.probability = 16.6
            item.uiSize = 16.6
            items.append(item)
        }
        model.items = items
        return model
    }
    
    func reload() {
        if reloadBlock != nil {
            reloadBlock!()
        }
    }
}
