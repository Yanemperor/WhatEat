//
//  ZLItemTitleCell.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/24.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ZLItemTitleCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    var model: ZLCircularModel? {
        didSet {
            titleTextField.text = model?.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.centerY.equalToSuperview()
        }
    }
    
    lazy var titleTextField: UITextField = {
        let temp = UITextField()
        temp.textColor = color_666666
        temp.textAlignment = .left
        temp.font = autoFont(font: 22)
        temp.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print(text)
            if !text.isEmpty {
                self.model?.title = text
            }else{
                self.model?.title = ""
            }
        }).disposed(by: disposeBag)
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
