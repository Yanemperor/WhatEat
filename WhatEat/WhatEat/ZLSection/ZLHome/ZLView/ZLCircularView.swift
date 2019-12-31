//
//  ZLCircularView.swift
//  WhatEat
//
//  Created by 周子龙 on 2019/12/19.
//  Copyright © 2019 zhouzilong. All rights reserved.
//

import UIKit
import RxSwift
import AVFoundation

class ZLCircularView: UIView {

    var disposeBag = DisposeBag()
    
    typealias ResultBlock = (ZLCircularItemModel) -> ()
    var resultBlock: ResultBlock?

    
    //设置圆点
    var centerPoint:CGPoint!
    var radius:CGFloat!
    var layerWidth: CGFloat = 100//圆环宽度
    
    var startAngle:Float = Float(CGFloat.pi / 2.0)
    var endAngle:Float = 0
    var allValue:Float = 0
    var dataSource: Array<ZLCircularItemModel> = []
    var awardViews: Array<ZLAwardView> = []
    
    var type: CircularType = .normal
    
    var colors = [color_fa5a5a, color_f0d264, color_82c8a0, color_7fccde,color_6698cb, color_cb99c5]
    var outBezerArrs = [Any]()
    var outLayers = [Any]()
    
    var rotatingAngle: CGFloat = 0
    // 结果
    var resultItemModel: ZLCircularItemModel?
    
    func drawPieChartView() {
        
        radius = frame.size.height / 2.0
        let width = (radius + radius * 1.5) * sqrt(2)
        let height = width
        baseView.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: width, height: height))
        }
        baseView.layer.cornerRadius = width / 2.0
        centerPoint = CGPoint.init(x: frame.size.width/2.0, y: frame.size.height/2.0)
        if dataSource.count % 2 == 0{
            startAngle = Float(CGFloat.pi / 2.0) - 2 * .pi / Float(dataSource.count) / 2
        }else{
            startAngle = Float(CGFloat.pi / 2.0)
        }
        allValue = 0
//        for index in 0...dataSource.count-1 {
//            allValue = allValue+Float(layerWidth)
//        }
        
        allValue = Float(layerWidth) * Float(dataSource.count)
        
        //for循环画图
        for index in 0..<dataSource.count {
            bezierPaint(index: index)
        }
        
        let tempA: CGFloat = 2 * CGFloat.pi / CGFloat(dataSource.count)
        
        
        
        for view in awardViews {
            view.removeFromSuperview()
        }
        
        for index in 0..<dataSource.count {
            let model = dataSource[index]
            var frame = CGRect(x: 0,
                               y: 0,
                               width: self.bounds.width / 2 * sin(2 * CGFloat.pi / CGFloat(dataSource.count)),
                               height: self.bounds.height)
            if dataSource.count <= 2 {
                frame = CGRect(x: 0,
                y: 0,
                width: 50,
                height: self.bounds.height)
            }
            let awardView = ZLAwardView(frame: frame)
            awardView.layer.anchorPoint = CGPoint(x: 0.5, y: 1);
            awardView.center = CGPoint(x: self.bounds.width / 2,
                                       y: self.bounds.width / 2)
            awardView.set(baseAngle: 270 * .pi / 180, radius: 75)
            awardView.set(title: model.title ?? "")
            let rotationAngle = CGFloat(tempA * CGFloat(index))
            awardView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            bgView.addSubview(awardView)
            awardViews.append(awardView)
        }
        bringSubviewToFront(topView)
    }
    
    
    //贝塞尔和CASherLayer画图
    func bezierPaint(index:Int) {
        
        let targetValue = Float(layerWidth)
        let ratioString = String(format: "%.5f", targetValue/Float(allValue))
        
        endAngle = startAngle + (Float(ratioString)!)*2*Float(Double.pi)
        
//        createView()
        //bezierPath形成闭合的扇形路径  外弧形
        let bezierOutPath = UIBezierPath.init()
        // 添加一条弧线
        bezierOutPath.addArc(withCenter: centerPoint, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        
        //////外弧形渲染
        let outLayer = CAShapeLayer.init()
        outLayer.lineWidth = radius * 1.5
        outLayer.fillColor =  UIColor.clear.cgColor
        outLayer.strokeColor = colors[index % colors.count].cgColor
        outLayer.path = bezierOutPath.cgPath
        bgView.layer.addSublayer(outLayer)
        let start = Float(layerWidth)
        let scaleString = String(format: "%.5f", start/Float(allValue))
        startAngle = startAngle+(Float(scaleString)!-1)*2*Float(Double.pi)
        outBezerArrs.append(bezierOutPath)
        outLayers.append(outLayer)
    }
    
    func randomResults() -> Int {
        var randomResults: Int = 0
        // 0~100 随机出来的数
        let random = arc4random() % UInt32(100)
        
        var intervals: Array<Float> = []
        var tempInterval: Float = 0
        
        // 获取区间
        for itemModel in dataSource {
            var interval: Float = itemModel.probability
            interval += tempInterval
            intervals.append(interval)
            tempInterval = interval
        }
        // 判断在哪个区间
        for index in 0..<intervals.count {
            if random < UInt32(intervals[index]) {
                randomResults = index
                break
            }
        }
        print(randomResults)
        return randomResults
    }
    
    func fanRotationAnim(rotationView: UIView) -> Void {
        
        
        let repeatCount: CGFloat = 4
        
        // 1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        // 2.设置动画属性
        rotationAnim.fromValue = rotatingAngle // 开始角度
        // 结束的角度
        // 随机到的结果
//        let random = arc4random() % UInt32(dataSource.count)
        let random = randomResults()
        resultItemModel = dataSource[Int(random)]
        print("结果" + "\(random)")
        
        let singleAngle = 2 * CGFloat.pi / CGFloat(dataSource.count)
        
        
        
//        let itemAngle = CGFloat(arc4random() % UInt32(10)) / 10 * singleAngle
//        print("旋转小角度" + "\(itemAngle)")
        
        
        
        
        rotatingAngle = 2 * CGFloat.pi - CGFloat(random) * singleAngle
        print("旋转角度" + "\(rotatingAngle)")
        rotationAnim.toValue = rotatingAngle + repeatCount * .pi * 4
        
        
        
        rotationAnim.duration = CFTimeInterval(repeatCount)
        rotationAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnim.autoreverses = false // 动画完成后自动重新开始,默认为NO
        rotationAnim.fillMode = .forwards
        rotationAnim.delegate = self
        rotationAnim.isRemovedOnCompletion = false //默认是true，切换到其他控制器再回来，动画效果会消失，需要设置成false，动画就不会停了
        rotationView.layer.add(rotationAnim, forKey: nil) // 给需要旋转的view增加动画
        let isVoice: Bool = UserDefaults.standard.object(forKey: ZLUserDefaultsKey.voiceName) as? Bool ?? true
        if isVoice {
            self.playMP3()
        }
    }
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()

    func playMP3() {
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            let path = Bundle.main.path(forResource: "rotary_rotating", ofType: "m4r")
            let soudUrl = URL(fileURLWithPath: path!)
            try audioPlayer = AVAudioPlayer(contentsOf: soudUrl, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1
            audioPlayer.numberOfLoops = 1
            audioPlayer.play()
            //自定义10s后关闭播放
            Timer.scheduledTimer(timeInterval: 3.8, target: self, selector: #selector(stopAudioPlayer), userInfo: nil, repeats: false)
        } catch{
            print(error)
        }
    }
    
    @objc func stopAudioPlayer() {
            audioPlayer.stop()
    }
    
    init() {
            super.init(frame: CGRect.zero)
            initUI()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            initUI()
        }
        
        func initUI() {
            self.addSubview(baseView)
            baseView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: autoSize(number: 180 * 2), height: autoSize(number: 180 * 2)))
            }
            self.addSubview(bgView)
            bgView.snp.makeConstraints { (make) in
                make.top.right.bottom.left.equalToSuperview()
            }
            self.addSubview(topView)
            topView.snp.makeConstraints { (make) in
                make.top.right.bottom.left.equalToSuperview()
            }
            topView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: autoSize(number: 75), height: autoSize(number: 75)))
            }
        }
        
        lazy var topView: UIView = {
            let temp = UIView()
            temp.backgroundColor = UIColor.clear
            return temp
        }()
        
        lazy var bgView: UIView = {
            let temp = UIView()
            temp.backgroundColor = UIColor.clear
            return temp
        }()
        
        lazy var baseView: UIView = {
            let temp = UIView()
            temp.backgroundColor = color_FFFFFF
            temp.layer.cornerRadius = 100
            temp.layer.masksToBounds = true
            temp.layer.borderColor = color_696969.cgColor
            temp.layer.borderWidth = 5
            return temp
        }()
        
        lazy var button: UIButton = {
            let temp = UIButton()
            temp.setBackgroundImage(UIImage(named: "circular_pointer"), for: .normal)
            temp.setBackgroundImage(UIImage(named: "circular_pointer"), for: .highlighted)
            temp.setTitle("开始", for: .normal)
            temp.setTitle("开始", for: .highlighted)
            temp.setTitleColor(color_333333, for: .normal)
            temp.setTitleColor(color_333333, for: .highlighted)
            temp.titleLabel?.font = autoFont(font: 16)
            temp.layer.cornerRadius = 25
            temp.layer.masksToBounds = true
            temp.rx.controlEvent(.touchUpInside).subscribe { (button) in
                self.fanRotationAnim(rotationView: self.bgView)

                }.disposed(by: disposeBag)
            return temp
        }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZLCircularView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        self.button.isUserInteractionEnabled = false
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.button.isUserInteractionEnabled = true
        if self.resultBlock != nil {
            self.resultBlock!(self.resultItemModel ?? ZLCircularItemModel())
        }
    }
}
