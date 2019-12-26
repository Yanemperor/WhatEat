//
//  ZLOtherViewModel.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/26.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLOtherViewModel: ZLBaseViewModel {
    
    typealias ReloadBlock = () -> ()
    var reloadBlock: ReloadBlock?

    
    var allCircularModels: Array<ZLCircularModel> = []

    func getCirculars() {
        allCircularModels = ZLDataBase.shared.getCircularTable() ?? []
        reload()
    }
    
    func removeModel(model: ZLCircularModel) {
        ZLDataBase.shared.deleteCircularTable(model: model)
        getCirculars()
    }
    
    func reload() {
        if reloadBlock != nil {
            reloadBlock!()
        }
    }
}
