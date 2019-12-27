//
//  ZLAboutViewController.swift
//  QuestionBank
//
//  Created by 周子龙 on 2019/10/14.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLAboutViewController: ZLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        navTitle(title: "关于我")
        view.addSubview(imageBgView)
        imageBgView.addSubview(aboutImageView)
        view.addSubview(hintBgView)
        hintBgView.addSubview(hintLabel)
        
        imageBgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 20))
            make.left.equalToSuperview().offset(autoSize(number: 20))
            make.right.equalToSuperview().offset(autoSize(number: -20))
        }
        aboutImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 10))
            make.right.equalToSuperview().offset(autoSize(number: -10))
            make.height.equalTo(aboutImageView.snp.width)
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
        hintBgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(autoSize(number: 20))
            make.top.equalTo(aboutImageView.snp.bottom).offset(autoSize(number: 20))
            make.right.equalToSuperview().offset(autoSize(number: -20))
        }
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 10))
            make.left.equalToSuperview().offset(autoSize(number: 10))
            make.right.equalToSuperview().offset(autoSize(number: -10))
            make.bottom.equalToSuperview().offset(autoSize(number: -10))
        }
    }
    
    lazy var imageBgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = color_ffffff
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
        return temp
    }()
    
    lazy var aboutImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "my_contact_us")
        return temp
    }()
    
    lazy var hintBgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = color_ffffff
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
        return temp
    }()
    
    lazy var hintLabel: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = UIColor.white
        temp.text = "如果您发现了任何BUG或者有什么建议都可以关注公众号联系作者。\n感谢您的支持！"
        temp.textColor = color_333333
        temp.textAlignment = NSTextAlignment.left
        temp.font = autoFont(font: 15)
        temp.numberOfLines = 0
        return temp
    }()
}
