//
//  ZLItemViewCell.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/24.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ZLItemViewCell: UITableViewCell {

    var disposeBag = DisposeBag()

    func setCircularItemModel(model: ZLCircularItemModel) {
        titleTextField.text = model.title
        probabilityTextField.text = String(model.probability)
        uiSizeTextField.text = String(model.uiSize)
    }
    
    var model: ZLCircularItemModel? {
        didSet {
            titleTextField.text = model?.title
            probabilityTextField.text = String(model!.probability)
            uiSizeTextField.text = String(model!.uiSize)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(titleTextField)
        contentView.addSubview(probabilityTextField)
        contentView.addSubview(uiSizeTextField)
        titleTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.width.equalTo(probabilityTextField.snp.width)
        }
        probabilityTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
        uiSizeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(autoSize(number: 10))
            make.right.equalToSuperview().offset(autoSize(number: -15))
            make.left.equalTo(probabilityTextField.snp.right).offset(autoSize(number: 10))
            make.width.equalTo(probabilityTextField.snp.width)
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
    }
    
    lazy var titleTextField: UITextField = {
        let temp = UITextField()
        temp.textColor = color_666666
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        temp.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print(text)
            if !text.isEmpty {
                self.model?.title = text
            }
        }).disposed(by: disposeBag)
        return temp
    }()
    
    lazy var probabilityTextField: UITextField = {
        let temp = UITextField()
        temp.textColor = color_666666
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        temp.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print(text)
            if !text.isEmpty {
                self.model?.probability = Float(text)!
            }
        }).disposed(by: disposeBag)
        return temp
    }()
    
    lazy var uiSizeTextField: UITextField = {
        let temp = UITextField()
        temp.textColor = color_666666
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        temp.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print(text)
            if !text.isEmpty {
                self.model?.uiSize = Float(text)!
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
