//
//  ZLTurntable.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/17.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit

class ZLReward {
    
    // 展示的奖项
    struct Lottery: Codable {
        let id: Int
        let begin: Float
        let end: Float
        let title: String
        let image: String
    }
    
    // 服务端返回抽中奖项
    struct Award {
        let id: Int
        let rotationNum: Int
    }
}

protocol ZLRewardViewDelegate: NSObjectProtocol {
    func animationDidStart(_ anim: CAAnimation)
    func animationDidStop(_ anim: CAAnimation)
    func lottery(_ completion: @escaping ((_ result: Bool, _ award: ZLReward.Award) -> Void))
}

class ZLRewardView: UIView {
    
    weak var delegate: ZLRewardViewDelegate?
    
    // 背景转盘
    lazy var awardsView: ZLCircularView = {
        let temp = ZLCircularView()
        temp.backgroundColor = color_ebebeb
        return temp
    }()
    
    lazy var rotateView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.blue
        return temp
    }()
    
    // 外围的装饰图层
//    private let backImageView = UIView()
    // 上次转动角度
    private var rotationAngle: CGFloat = 0
    // 动画是否正在执行
    private var isAnimating: Bool = false
    
    private var lotteries: [ZLReward.Lottery] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLayout()
    }
    
    private func setup() {
        addSubview(rotateView)
        addSubview(playButton)
//        addSubview(backImageView)
        rotateView.addSubview(wheelImageView)
        rotateView.addSubview(awardsView)
//        backImageView.contentMode = .scaleToFill
//        wheelImageView.backgroundColor = color_333333
//        backImageView.backgroundColor = color_2e2e2e
    }
    
    private func setupLayout() {
        rotateView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(rotateView.snp.width)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(autoSize(number: 50))
            make.center.equalTo(rotateView.snp.center)
        }
        
        wheelImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        awardsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
//        backImageView.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().offset(5)
//            make.centerX.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(rotateView.snp.height).offset(30)
//        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    deinit {
        rotateView.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    @objc private func lottery() {
        guard !isAnimating else { return }
        delegate?.lottery({ [weak self] (result, award)  in
            guard let self = self, result else { return }
            self.startAnimation(num: award.rotationNum, awardId: award.id)
        })
    }
    
    /// 开始旋转动画
    ///
    /// - Parameters:
    ///   - num: 转动圈数
    ///   - awardId: 所中奖品Id
    private func startAnimation(num: Int, awardId: Int) {
        guard
            !isAnimating,
            let lottery = lotteries.first(where: { $0.id == awardId }) else {
                return
        }
        
        let rotationAngle = -CGFloat((lottery.begin + lottery.end) / 360.0 * .pi )
        self.rotationAngle = rotationAngle
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = rotationAngle + 360 * .pi / 180.0 * CGFloat(num)
        animation.duration = CFTimeInterval(num) + 0.5
        animation.isCumulative = false
        animation.delegate = self
        
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        rotateView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    // 开始按钮
    lazy var playButton: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = UIColor.orange
        temp.setTitle("开始", for: .normal)
        temp.setTitleColor(UIColor.white, for: .normal)
        temp.layer.cornerRadius = autoSize(number: 50) / 2.0
        temp.layer.masksToBounds = true
        temp.addTarget(self, action: #selector(lottery), for: .touchUpInside)
        return temp
    }()
    
    lazy var wheelImageView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.white
        temp.layer.cornerRadius = autoSize(number: 300) / 2.0
        temp.layer.masksToBounds = true
        temp.layer.borderColor = color_999999.cgColor
        temp.layer.borderWidth = 0.5
        return temp
    }()
    
    
}

extension ZLRewardView {
    
    func set(lotteries: [ZLReward.Lottery]) {
        self.lotteries = lotteries
        reloadData()
    }
    
    private func reloadData() {
        layoutIfNeeded()
        // 移除子视图
        for view in awardsView.subviews {
            view.removeFromSuperview()
        }
        // 添加 awardView 视图
        for lottery in lotteries {
            
            let ratio = CGFloat(lottery.end - lottery.begin)/360.0
            let angle = (ratio > 0.5 ? 0.5 : ratio) * .pi
            let frame = CGRect(x: 0,
                               y: 0,
                               width: rotateView.bounds.width / 2 * sin(angle),
                               height: rotateView.bounds.height / 2)
            
            let awardView = ZLAwardView(frame: frame)
            awardView.layer.anchorPoint = CGPoint(x: 0.5, y: 1);
            awardView.center = CGPoint(x: rotateView.bounds.width / 2,
                                       y: rotateView.bounds.width / 2)
            awardView.set(baseAngle: 270 * .pi / 180, radius: 75)
            awardView.set(title: lottery.title)
            let rotationAngle = CGFloat((lottery.begin + lottery.end) / 360.0 * .pi )
            awardView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            awardsView.addSubview(awardView)
        }
    }
}

extension ZLRewardView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        isAnimating = true
        delegate?.animationDidStart(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isAnimating = false
        // rotateView 旋转到当前位置
        rotateView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        rotateView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        delegate?.animationDidStop(anim)
    }
}
