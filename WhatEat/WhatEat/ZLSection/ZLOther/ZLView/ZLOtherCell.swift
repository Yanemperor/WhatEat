//
//  ZLOtherCell.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/26.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ZLOtherCell: BaseTableViewCell {
    var disposeBag = DisposeBag()

    typealias EditBlock = (ZLCircularModel) -> ()
    
    var editBlock: EditBlock?

    
    var model: ZLCircularModel? {
        didSet {
            titleLabel.text = model?.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    func initUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(editBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 15))
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(editBtn.snp.left).offset(autoSize(number: 20))
        }
        editBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(autoSize(number: -15))
            make.centerY.equalToSuperview()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = color_333333
        temp.textAlignment = .left
        temp.font = autoFont(font: 16)
        return temp
    }()
    
    lazy var editBtn: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = color_ffffff
        temp.setImage(UIImage(named: "other_edit"), for: .normal)
        temp.rx.controlEvent(.touchUpInside).subscribe { (button) in
            if self.editBlock != nil {
                self.editBlock!(self.model ?? ZLCircularModel())
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
