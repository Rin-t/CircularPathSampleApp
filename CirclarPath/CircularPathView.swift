//
//  CircularPathView.swift
//  CirclarPath
//
//  Created by Rin on 2021/09/26.
//

import UIKit

final class CircularPathView: UIView {

    // 原点を中心とする単位円とpiとの関係
    // (1,0) → 0, (2 * CGFloat.pi)
    // (0,1) → (-CGFloat.pi / 2), (CGFloat.pi * 3 / 2)
    // (-1,0) → CGFloat.pi, -CGFloat.pi
    // (1,0) → (CGFloat.pi / 2), (-CGFloat.pi * 3 / 2)
    // この値を用いて自由にstartPointとendPointを決められます
    private let startPoint = -CGFloat.pi / 2
    private let endPoint = CGFloat.pi * 3 / 2
    private let backGroundPathLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func create(radius: CGFloat) {
        // pathの設定
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2), radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)

        // CGPath()を使うと四角とかにもできる
        backGroundPathLayer.path = bezierPath.cgPath
        backGroundPathLayer.lineWidth = 10
        backGroundPathLayer.fillColor = UIColor.clear.cgColor
        backGroundPathLayer.strokeColor = UIColor.systemGray4.cgColor
        layer.addSublayer(backGroundPathLayer)

        progressLayer.path = bezierPath.cgPath
        progressLayer.lineWidth = 5
        // 線を描き始める場所0~1までの値を取る
        progressLayer.strokeStart = 0
        // 線を描き終える場所0~1までの値を取る
        // ただし、func progressAnimation(duration: Int)を使う場合はこのポイントで終わらなくなってしまう
        // func progressAnimation(duration: Int)と併用する場合は0にしておくと良い
        progressLayer.strokeEnd = 0
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.orange.cgColor
        // 設定するとタイマーのアニメションを点線で書ける
        progressLayer.lineDashPattern = [20, 10]
        layer.addSublayer(progressLayer)
    }

    func progressAnimation(duration: Int) {
        // ketPathはいくつか種類がある
        // opacityにすると、透明から徐々に濃くなっていくようなアニメーションになる
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // アニメーションの時間を設定
        circularProgressAnimation.duration = TimeInterval(duration)
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }

    func pauseAnimation(){
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    func resumeAnimation(){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }




}
