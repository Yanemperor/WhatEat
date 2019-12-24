//
//  ZLCircularItemModel.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import WCDBSwift

class ZLCircularItemModel: ZLBaseModel, TableCodable {
    var title: String?              // 选项名
    var probability: Int = 0        // 概率  都为一百则为均分
    var uiSize: Float = 0.0              // 转盘项大小 都为一百则为均分
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ZLCircularItemModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case title
        case probability
        case uiSize
    }
}
