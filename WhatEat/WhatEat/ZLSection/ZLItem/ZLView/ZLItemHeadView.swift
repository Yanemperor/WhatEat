//
//  ZLItemHeadView.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLItemHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.centerY.equalToSuperview()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = color_ffffff
        temp.text = "吃啥呀？"
        temp.textColor = color_333333
        temp.textAlignment = .center
        temp.font = autoFont(font: 22)
        return temp
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
