//
//  ZLSetCell.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/26.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ZLSetCell: UITableViewCell {


    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(rightSwitch)
        bgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(autoSize(number: 10))
            make.bottom.right.equalToSuperview().offset(autoSize(number: -10))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
        rightSwitch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(autoSize(number: -15))
            make.centerY.equalToSuperview()
        }
    }
    
    lazy var bgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = color_ffffff
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.text = ""
        temp.textColor = color_333333
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        return temp
    }()
    
    lazy var rightSwitch: UISwitch = {
        let temp = UISwitch()
        temp.isHidden = true
        
        return temp
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
