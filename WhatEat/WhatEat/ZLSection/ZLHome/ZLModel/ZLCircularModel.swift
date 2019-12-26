//
//  ZLCircularModel.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import WCDBSwift

class ZLCircularModel: ZLBaseModel, TableCodable {
    var id: Int = 0
    var title: String?
    var type: Bool = true
    var items: Array<ZLCircularItemModel> = []
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ZLCircularModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case title
        case type
        case items
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                id: ColumnConstraintBinding(isPrimary: true),
            ]
        }
    }
    
//    var isAutoIncrement: Bool = true // 用于定义是否使用自增的方式插入
//    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
}

