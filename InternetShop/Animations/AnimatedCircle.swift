//
//  AnimatedCircle.swift
//  InternetShop
//
//  Created by Kiri4of on 14.02.2023.
//

import UIKit

class AnimatedCircle: UIView {
    
    let circleLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    let startPoint = -CGFloat.pi / 2
    let endPoint = (3 * CGFloat.pi) / 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configCircularPath()
    }
    
    func configCircularPath() {
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: 50, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        //circleLayer
        circleLayer.path = path.cgPath
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 16
        circleLayer.strokeEnd = 1
        layer.addSublayer(circleLayer)
        
        //progressLayer
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.fillColor =  UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 8
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProggresAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProggresAnimation.duration = duration
        circularProggresAnimation.toValue = 1
        circularProggresAnimation.fillMode = .forwards
        circularProggresAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProggresAnimation, forKey: "progressAnimation")
    }
}

