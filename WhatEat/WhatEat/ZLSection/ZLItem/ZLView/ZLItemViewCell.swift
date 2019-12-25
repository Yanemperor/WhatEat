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
    
    typealias DelBlock = (ZLCircularItemModel) -> ()
    
    var delBlock: DelBlock?

    
    var model: ZLCircularItemModel? {
        didSet {
            titleTextField.text = model?.title
            if model?.probability == 0 {
                probabilityTextField.text = ""
            }else{
                probabilityTextField.text = String(format:"%.2f",model!.probability)
            }
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
        bgView.addSubview(probabilityTitleLabel)
        bgView.addSubview(probabilityTextField)
        bgView.addSubview(delBtn)
        bgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(autoSize(number: 10))
            make.bottom.right.equalToSuperview().offset(autoSize(number: -10))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 15))
        }
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(autoSize(number: 10))
            make.right.equalTo(delBtn.snp.left).offset(autoSize(number: -20))
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(probabilityTextField.snp.width)
        }
        probabilityTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
        probabilityTextField.snp.makeConstraints { (make) in
            make.left.equalTo(probabilityTitleLabel.snp.right).offset(autoSize(number: 10))
            make.right.equalTo(delBtn.snp.left).offset(autoSize(number: -20))
            make.centerY.equalTo(probabilityTitleLabel.snp.centerY)
        }
        delBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(autoSize(number: -15))
        }
//        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
//        titleTextField.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)

        probabilityTitleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        probabilityTextField.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
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
        temp.text = "选项"
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
        temp.placeholder = "请输入选项(必填)"
        temp.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print(text)
            if !text.isEmpty {
                self.model?.title = text
            }
        }).disposed(by: disposeBag)
        return temp
    }()
    
    lazy var probabilityTitleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "概率"
        temp.textColor = color_333333
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        return temp
    }()
    
    lazy var probabilityTextField: UITextField = {
        let temp = UITextField()
        temp.textColor = color_666666
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        temp.placeholder = "请输入概率,点击均分自动获取(必填)"
        temp.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print(text)
            if !text.isEmpty {
                self.model?.probability = Float(text)!
            }
        }).disposed(by: disposeBag)
        return temp
    }()
    
    lazy var delBtn: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = color_ffffff
        temp.setImage(UIImage(named: "item_del"), for: .normal)
        temp.rx.controlEvent(.touchUpInside).subscribe { (button) in
            if self.delBlock != nil {
                self.delBlock!(self.model!)
            }
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
