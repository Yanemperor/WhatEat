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
    var allCircularModels: Array<ZLCircularModel> = []
    
    var itemTitle: Array<String> = ["火锅","炒菜","饺子","炒饭","粥","面条"]
    var itemTitle1: Array<String> = ["北京","上海","广州","深圳","杭州","武汉"]
    var itemTitle2: Array<String> = ["爬山","散步","逛街","玩游戏","刷剧","看电影"]

    
    func getCircular() {
        allCircularModels = ZLDataBase.shared.getCircularTable() ?? []
        if allCircularModels.count > 0 {
            circularModel = allCircularModels[0]
        }else{
            allCircularModels = setAllInitCircularModel()
            circularModel = allCircularModels[0]
            ZLDataBase.shared.insertCircularTable(array: allCircularModels)
        }
        reload()
    }
    
    func getCircular(id: Int) {
        let temp: ZLCircularModel = ZLDataBase.shared.getCircularTable(id: id)!
        circularModel = temp
        reload()
    }
    
    func setAllInitCircularModel() -> [ZLCircularModel] {
        var alls: Array<ZLCircularModel> = []
        alls.append(getInitCircularModel(title: "吃啥呀？", id: 0, itemTitles: itemTitle))
        alls.append(getInitCircularModel(title: "去哪呀？", id: 1, itemTitles: itemTitle1))
        alls.append(getInitCircularModel(title: "干啥呀？", id: 2, itemTitles: itemTitle2))
        return alls
    }
    
    func getInitCircularModel(title: String, id: Int, itemTitles: Array<String>) -> ZLCircularModel {
        let model = ZLCircularModel()
        model.title = title
        model.type = true
        model.id = id
        var items: Array<ZLCircularItemModel> = []
        for itemTitle in itemTitles {
            let item: ZLCircularItemModel = ZLCircularItemModel()
            item.title = itemTitle
            item.probability = 100.0 / Float(itemTitles.count)
            item.uiSize = 100
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
