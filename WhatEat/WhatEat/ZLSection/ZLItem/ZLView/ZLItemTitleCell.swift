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
    
    typealias DivideBlock = (Bool) -> ()
    
    var divideBlock: DivideBlock?

    
    
    var model: ZLCircularModel? {
        didSet {
            titleTextField.text = model?.title
            divideSwitch.isOn = model?.type ?? true
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(titleTextField)
        bgView.addSubview(divideTitleLabel)
        contentView.addSubview(divideSwitch)
        bgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(autoSize(number: 10))
            make.bottom.right.equalToSuperview().offset(autoSize(number: -10))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 15))
        }
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(autoSize(number: 10))
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        divideTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.top.equalTo(titleLabel.snp.bottom).offset(autoSize(number: 10))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
        divideSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(divideTitleLabel.snp.centerY)
            make.right.equalTo(bgView.snp.right).offset(autoSize(number: -15))
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
           temp.text = "标题"
           temp.textColor = color_333333
           temp.textAlignment = .left
           temp.font = autoFont(font: 16)
           return temp
       }()
    
    lazy var titleTextField: UITextField = {
        let temp = UITextField()
        temp.textColor = color_666666
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        temp.placeholder = "请输入标题(非必填)"
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
    
    lazy var divideTitleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "是否均分"
        temp.textColor = color_333333
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        return temp
    }()
    
    lazy var divideSwitch: UISwitch = {
        let temp = UISwitch()
        temp.rx.isOn.asObservable().subscribe(onNext: { (bool) in
            if self.divideBlock != nil {
                self.divideBlock!(bool)
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
