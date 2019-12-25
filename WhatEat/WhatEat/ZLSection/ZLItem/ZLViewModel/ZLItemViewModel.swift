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
        if (self.model?.items.count)! <= 2 {
            ZLHUD.show(text: "最小为两项", type: .warning)
            return
        }
        self.model?.items.removeAll(where: { (tempModel) -> Bool in
            let results: Bool = (tempModel === model)
            return results
        })

    }
    
    func polishingItemData(model: ZLCircularItemModel) {
        var allProbability: Float = 0
        for itemModel in self.model!.items {
            if model === itemModel {
                
            }else{
                allProbability += itemModel.probability
            }
        }
        model.probability = 100 - allProbability
    }
    
    func isSave() -> Bool {
        if model?.items.count ?? 1 <= 1 {
            return false
        }
        for itemModel in model!.items {
            if itemModel.title == "" || itemModel.title == nil {
                ZLHUD.show(text: "请输入选项!", type: .warning)
                return false
            }
            if itemModel.probability == 0 || itemModel.title == nil {
                ZLHUD.show(text: "请输入概率!", type: .warning)
                return false
            }
            if itemModel.probability < 1 {
                ZLHUD.show(text: "概率最低为1%", type: .warning)
                return false
            }
        }
        return true
    }
}
