//
//  ProfileAnimationRefreshView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/27.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ProfileAnimationRefreshView: UIView,CAAnimationDelegate {
    
    let strokeKey = "strokeKey"
    let rotationKey = "rotationKey"
    var circleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layer = CALayer()
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        
        let leftLayer = CAGradientLayer()
        leftLayer.startPoint = CGPoint(x: 0, y: 0)
        leftLayer.endPoint = CGPoint(x: 0, y: 1)
        leftLayer.colors = [UIColor.white.cgColor,UIColor.init(white: 1, alpha: 0.5).cgColor]
        layer.addSublayer(leftLayer)
        leftLayer.frame = CGRect(x: 0, y: 0, width: self.width/2, height: self.height)
        
        let rightLayer = CAGradientLayer()
        rightLayer.startPoint = CGPoint(x: 1, y: 0)
        rightLayer.endPoint = CGPoint(x: 1, y: 1)
        rightLayer.colors = [UIColor.init(white: 1, alpha: 0).cgColor,UIColor.init(white: 1, alpha: 0.5).cgColor]
        layer.addSublayer(rightLayer)
        rightLayer.frame = CGRect(x: self.width/2, y: 0, width: self.width/2, height: self.height)
        
        let lineWith : CGFloat = 2;
        
        let rect = CGRect(x: lineWith, y: lineWith, width: self.width - 2*lineWith, height: self.height - 2*lineWith);
        self.circleLayer.frame = rect
        self.circleLayer.strokeColor = UIColor.colorWithHexString("#5e5e5e").cgColor
        self.circleLayer.fillColor = nil
        self.circleLayer.lineCap = kCALineCapRound
        self.circleLayer.lineWidth = CGFloat(lineWith)
        self.circleLayer.path = UIBezierPath.init(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2), radius: rect.width/2, startAngle:-CGFloat.pi/2 + 0.1, endAngle: 1.5 * CGFloat.pi, clockwise: true).cgPath
        self.circleLayer.strokeStart = 0;
        self.circleLayer.strokeEnd = 0;
        self.layer.mask = self.circleLayer
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation(){
        let strokeAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        strokeAnimation.isRemovedOnCompletion = false
        strokeAnimation.fillMode = kCAFillModeForwards
        strokeAnimation.duration = 0.6
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = 0.88
        strokeAnimation.repeatCount = 1
        strokeAnimation.delegate = self
        self.circleLayer.add(strokeAnimation, forKey: strokeKey)
    }
    
    func ednAnimation(){
        self.layer.removeAnimation(forKey: rotationKey)
        self.circleLayer.removeAnimation(forKey: strokeKey)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        if anim == self.circleLayer.animation(forKey: strokeKey) {
            let theAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
            theAnimation.isRemovedOnCompletion = false
            theAnimation.fillMode = kCAFillModeForwards
            theAnimation.duration = 0.6
            theAnimation.fromValue = 0
            theAnimation.toValue = Double.pi * 2
            theAnimation.repeatCount = MAXFLOAT
            self.layer.add(theAnimation, forKey: rotationKey)
        }
    }
}
