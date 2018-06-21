//
//  LoadingCircleLayer.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/6.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

let kRotationAnimateKey = "kRotationAnimateKey"
let kCircleStrokeKey = "kCircleStrokeKey"

class LoadingCircleLayer: CALayer {
    
    var darkLayer : CAShapeLayer! = nil
    var lightLayer : CAShapeLayer! = nil
    
    func addProgressLayer() {
        darkLayer = CAShapeLayer()
        darkLayer.lineWidth = 4.7/2
        darkLayer.strokeColor = UIColor.colorWithHexString("#B4B5B7").cgColor
        darkLayer.fillColor = nil
        darkLayer.strokeStart = 0;
        darkLayer.strokeEnd = 0;
        self.addSublayer(darkLayer)
        
        lightLayer = CAShapeLayer()
        lightLayer.lineWidth = 4.7/2
        lightLayer.strokeColor = UIColor.colorWithHexString("#CCCDCE").cgColor
        lightLayer.fillColor = nil
        lightLayer.strokeStart = 0;
        lightLayer.strokeEnd = 0;
        self.addSublayer(lightLayer)
        
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.height/2 - 4.7/4
        let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi * 1.5), clockwise: true)
        darkLayer.path = path.cgPath
        lightLayer.path = path.cgPath

    }

    func beginAnimation() {
        let animation = CAKeyframeAnimation.init(keyPath:"strokeEnd")
        animation.isAdditive = true
        animation.values = [0.78,0.2,0.78]
        animation.keyTimes = [0,0.5,1]
        animation.repeatCount = MAXFLOAT
        animation.duration = 1.832
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.darkLayer.add(animation, forKey: kCircleStrokeKey)
        
        let animation2 = CAKeyframeAnimation.init(keyPath:"strokeEnd")
        animation2.isAdditive = true
        animation2.values = [0.12,0.04,0.12]
        animation2.keyTimes = [0,0.5,1]
        animation2.repeatCount = MAXFLOAT
        animation2.duration = 1.832
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = kCAFillModeForwards
        self.lightLayer.add(animation2, forKey: kCircleStrokeKey)
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.duration = 0.916
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.repeatCount = MAXFLOAT
        self.add(rotationAnimation, forKey: kRotationAnimateKey)
    }

    func endAnimation() {
        self.removeAnimation(forKey: kRotationAnimateKey)
        self.lightLayer.removeAllAnimations()
        self.darkLayer.removeAllAnimations()
        self.lightLayer.strokeEnd = 0
        self.darkLayer.strokeEnd = 0
    }
}
