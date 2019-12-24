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
    var type: Int = 0
    var items: Array<ZLCircularItemModel> = []
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ZLCircularModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case title
        case type
        case items
    }
    
}

