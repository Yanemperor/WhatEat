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
    
    typealias ReloadBlock = () -> ()
    
    var reloadBlock: ReloadBlock?

    
    var model: ZLCircularModel? {
        didSet {
            titleTextField.text = model?.title
        }
    }
    
    func divideBtnClick() {
        let divide: Float = Float(100.0 / Double(model?.items.count ?? 1))
        for index in model?.items ?? [] {
            index.probability = divide
        }
        if reloadBlock != nil {
            reloadBlock!()
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
        contentView.addSubview(divideBtn)
        bgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(autoSize(number: 10))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
            make.right.equalTo(divideBtn.snp.left).offset(autoSize(number: -10))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
            make.centerY.equalToSuperview()
        }
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(autoSize(number: 10))
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        divideBtn.snp.makeConstraints { (make) in
            make.width.equalTo(autoSize(number: 60))
            make.height.equalTo(bgView.snp.height)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(autoSize(number: -15))
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
    
    lazy var divideBtn: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = color_ffffff
        temp.setTitle("均分", for: .normal)
        temp.setTitleColor(color_333333, for: .normal)
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
        temp.rx.controlEvent(.touchUpInside).subscribe { (button) in
            self.divideBtnClick()
        }.disposed(by: disposeBag)
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
