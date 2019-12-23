//
//  ZLAwardView.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/17.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLAwardView: UIView {
    
    private let textArcView = ZLTextArcView()
    private var baseAngle: CGFloat = 0
    private var radius: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLayout()
    }
    
    private func setup() {
        addSubview(textArcView)
    }
    
    private func setupLayout() {
        textArcView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func set(baseAngle: CGFloat, radius: CGFloat) {
        // 设置圆弧 Label
        textArcView.textAttributes = [.foregroundColor: UIColor.white,
                                      .font: UIFont.systemFont(ofSize: 16)]
        textArcView.characterSpacing = 0.85
        textArcView.baseAngle = baseAngle
        textArcView.radius = radius * 1.5
        textArcView.verticalTextAlignment = .outside
    }
    
    func set(title: String) {
        textArcView.text = title

    }

}
