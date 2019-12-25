//
//  ZLItemViewModel.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLItemViewModel: ZLBaseViewModel {
    var model: ZLCircularModel?
    
    func saveDB() {
        ZLDataBase.shared.deleteCircularTable(model: model!)
        ZLDataBase.shared.insertCircularTable(array: [model!])
    }
    
    func removeItemData(model: ZLCircularItemModel) {
        self.model?.items.removeAll(where: { (tempModel) -> Bool in
            let results: Bool = (tempModel === model)
            return results
        })

    }
}
