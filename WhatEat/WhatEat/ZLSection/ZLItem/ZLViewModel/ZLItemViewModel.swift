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
    
    var isHiddenPolishing: Bool = true
    
    func saveDB() {
        ZLDataBase.shared.insertOrReplaceCircularTable(model: model!)
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
        if isHiddenPolishing {
            divideProbability()
        }
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
    
    func isOpenDivide(on: Bool) {
        if on {
            model?.type = true
            divideProbability()
        }else{
            model?.type = false
        }
        isHiddenPolishing = model?.type ?? true
    }
    
    // 均分概率
    func divideProbability() {
        let divide: Float = Float(100.0 / Double(model?.items.count ?? 1))
        for index in model?.items ?? [] {
            index.probability = divide
        }
    }
    
    func isSave() -> Bool {
        if model?.items.count ?? 1 <= 1 {
            ZLHUD.show(text: "选项最少为两项!", type: .warning)
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
        
        var allProbability: Float = 0
        for itemModel in self.model!.items {
            allProbability += itemModel.probability
        }
        if allProbability > 100 {
            ZLHUD.show(text: "概率之和不能大于100", type: .warning)
            return false
        }
        
        return true
    }
}
