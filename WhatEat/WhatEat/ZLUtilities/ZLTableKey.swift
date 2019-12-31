//
//  ZLTableKey.swift
//  QuestionBank
//
//  Created by 周子龙 on 2019/10/11.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import Foundation

//
struct ZLTableKey {
    static let circularTable = "CircularTable"        // 转盘数据表
}

struct ZLUserDefaultsKey {
    static let voiceName = "Voice"                  // 声音
    static let vibrationName = "Vibration"          // 震动
}


struct ZLAppConfigKey {
    static let buglyID = "3cf4f02947"                // Bugly APPID
    static let isUpDB = "isUpDB"                    // 是否更新数据库
    static let currentVersion = "currentVersion"                    // 当前版本号
}
