//
//  ZLResultView.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/23.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLResultView: UIView {

    func setCircularItemModel(model: ZLCircularItemModel) {
        self.isHidden = false
        titleLabel.text = model.title
    }
    
    init() {
        super.init(frame: CGRect.zero)
        initUI()
    }
    
    func initUI() {
        self.backgroundColor = UIColor.colorWithRGB(r: 0, g: 0, b: 0, alpha: 0)
        self.addSubview(bgColorView)
        self.addSubview(bgView)
        bgView.addSubview(imageView)
        bgView.addSubview(titleLabel)
        bgColorView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.right.equalToSuperview().offset(autoSize(number: -15))
            make.center.equalToSuperview()
            make.height.equalTo(autoSize(number: 240))
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 20))
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(autoSize(number: 10))
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    @objc func viewClick() {
        self.isHidden = true
    }
    
    lazy var bgColorView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.colorWithRGB(r: 0, g: 0, b: 0, alpha: 0.3)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewClick))
        temp.addGestureRecognizer(tap)
        return temp
    }()
    
    lazy var bgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.white
        temp.layer.cornerRadius = 15
        temp.layer.masksToBounds = true
        return temp
    }()
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "results_chickenleg")
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = color_ffffff
        temp.textColor = color_333333
        temp.textAlignment = .center
        temp.font = autoFont(font: 16)
        return temp
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
        
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
