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
//        tableView.rowHeight = 50
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(aboutImageView)
        view.addSubview(hintLabel)
//        view.addSubview(thankBtn)
        aboutImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(autoSize(number: 20))
            make.left.equalToSuperview().offset(autoSize(number: 20))
            make.right.equalToSuperview().offset(autoSize(number: -20))
            make.height.equalTo(aboutImageView.snp.width)
        }
        hintLabel.snp.makeConstraints { (make) in
            make.left.equalTo(aboutImageView.snp.left)
            make.top.equalTo(aboutImageView.snp.bottom).offset(autoSize(number: 20))
            make.right.equalToSuperview().offset(autoSize(number: -20))
        }
//        thankBtn.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize(width: autoSize(number: 100), height: autoSize(number: 40)))
//            make.centerX.equalToSuperview()
//            make.top.equalTo(hintLabel.snp.bottom).offset(autoSize(number: 30))
//        }
    }
    
    
    lazy var aboutImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "my_contact_us")
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
    
//    lazy var thankBtn: UIButton = {
//        let temp = UIButton()
//        temp.backgroundColor = color_3CB371
//        temp.setTitle("感谢作者", for: .normal)
//        temp.setTitleColor(UIColor.white, for: .normal)
//        temp.layer.masksToBounds = true
//        temp.layer.cornerRadius = 5
//        temp.rx.controlEvent(.touchUpInside).subscribe(onNext: { (button) in
//            let vc = ZLRecommendedViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }).disposed(by: disposeBag)
//        return temp
//    }()

}
