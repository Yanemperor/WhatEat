//
//  ZLItemFooterCell.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/25.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ZLItemFooterCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 30))
            make.right.equalToSuperview().offset(autoSize(number: -30))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
            make.height.equalTo(autoSize(number: 45))
        }
    }
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = color_ffffff
        temp.text = "添加新选项"
        temp.textColor = color_333333
        temp.textAlignment = .center
        temp.font = autoFont(font: 16)
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
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
