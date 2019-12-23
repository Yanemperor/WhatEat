//
//  ZLHomeViewController.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/17.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLHomeViewController: ZLBaseViewController {

    private var id: Int = 8

    var dataSource: Array<ZLCircularItemModel> = []
    
    var vm: ZLCircularViewModel = ZLCircularViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    
    func initData() {
        vm.getCircular()
        vm.reloadBlock = {
            
        }
    }
    
    func initUI() {
        navTitle(title: "吃啥呀？")
        setRightBarButtonItem(name: "nav_set", type: .image) {
            let vc = ZLSetViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        view.addSubview(circularView)
        view.addSubview(leftBtn)
        view.addSubview(rightBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: autoSize(number: 60), height: autoSize(number: 30)))
            make.top.equalTo(circularView.snp.bottom).offset(autoSize(number: 100))
            make.left.equalToSuperview().offset(autoSize(number: 40))
        }
        rightBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: autoSize(number: 60), height: autoSize(number: 30)))
            make.top.equalTo(circularView.snp.bottom).offset(autoSize(number: 100))
            make.right.equalToSuperview().offset(autoSize(number: -40))
        }
        
        UIApplication.shared.keyWindow?.addSubview(resultView)
    }
    
    lazy var circularView: ZLCircularView = {
        let temp = ZLCircularView()
        temp.size = CGSize(width: autoSize(number: 180), height: autoSize(number: 180))
        temp.centerX = self.view.centerX
        temp.centerY = self.view.centerY - 100
        temp.dataSource = vm.circularModel!.items
        temp.drawPieChartView()
        temp.resultBlock = { item in
            self.resultView.setCircularItemModel(model: item)
        }
        return temp
    }()
    
    lazy var leftBtn: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = color_ffffff
        temp.setTitle("选项", for: .normal)
        temp.setTitleColor(color_333333, for: .normal)
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
        temp.rx.controlEvent(.touchUpInside).subscribe { (button) in
            let vc = ZLItemViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        return temp
    }()
    
    lazy var rightBtn: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = color_ffffff
        temp.setTitle("其他", for: .normal)
        temp.setTitleColor(color_333333, for: .normal)
        temp.layer.cornerRadius = 8
        temp.layer.masksToBounds = true
        temp.layer.borderWidth = 1
        temp.layer.borderColor = color_333333.cgColor
        temp.rx.controlEvent(.touchUpInside).subscribe { (button) in
            let vc = ZLOtherViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        return temp
    }()
    
    lazy var resultView: ZLResultView = {
        let temp = ZLResultView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        temp.isHidden = true
        return temp
    }()

}



