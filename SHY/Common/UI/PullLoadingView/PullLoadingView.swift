//
//  PullLoadingView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/6.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

enum PullLoadingStatus {
    case stop
    case loading
}

class ArrowLayer: CALayer {
    var grayLayer : CAShapeLayer! = nil
    var darkLayer : CAShapeLayer! = nil
    var leftLayer : CAShapeLayer! = nil
    var rightLayer : CAShapeLayer! = nil
    var isArrowRotation : Bool! = false
    
    func addArrowLayer(){
        let width : CGFloat = self.frame.size.width
        let lightGrayLength : CGFloat = 3.5
        let vLenght : CGFloat = 14.0
        let hLength : CGFloat = 10.0
        let lineWith : CGFloat = 2.35
        
        grayLayer = CAShapeLayer()
        grayLayer.frame = self.bounds
        grayLayer.strokeColor = UIColor.colorWithHexString("#cccdce").cgColor
        grayLayer.fillColor = nil
        grayLayer.lineWidth = CGFloat(lineWith)
        let linePath = UIBezierPath.init()
        linePath.move(to: CGPoint(x: width/2, y: CGFloat(vLenght + lightGrayLength)))
        linePath.addLine(to: CGPoint(x: width/2, y: 0))
        grayLayer.path = linePath.cgPath
        self.addSublayer(grayLayer)
        
        darkLayer = CAShapeLayer()
        darkLayer.frame = self.bounds
        darkLayer.strokeColor = UIColor.colorWithHexString("#B4B5B7").cgColor
        darkLayer.fillColor = nil
        darkLayer.lineWidth = CGFloat(lineWith)
        let linePath2 = UIBezierPath.init()
        linePath2.move(to: CGPoint(x: width/2, y: CGFloat(vLenght + lightGrayLength)))
        linePath2.addLine(to: CGPoint(x: width/2, y: CGFloat(lightGrayLength)))
        darkLayer.path = linePath2.cgPath
        self.addSublayer(darkLayer)
        
        leftLayer = CAShapeLayer()
        leftLayer.frame = self.bounds
        leftLayer.strokeColor = UIColor.colorWithHexString("#B4B5B7").cgColor
        leftLayer.fillColor = nil
        leftLayer.lineWidth = CGFloat(lineWith)
        let linePath3 = UIBezierPath.init()
        let point = CGPoint(x: CGFloat(width/2 - CGFloat(lineWith) * sqrt(2)/4), y: CGFloat(lightGrayLength + vLenght + CGFloat(lineWith)/2 - lineWith * sqrt(2)/4))
        linePath3.move(to: point)
        linePath3.addLine(to: CGPoint(x: (point.x + hLength * sqrt(2)/2), y: (point.y - hLength * sqrt(2)/2)))
        leftLayer.path = linePath3.cgPath
        self.addSublayer(leftLayer)
        
        rightLayer = CAShapeLayer()
        rightLayer.frame = self.bounds
        rightLayer.strokeColor = UIColor.colorWithHexString("#B4B5B7").cgColor
        rightLayer.fillColor = nil
        rightLayer.lineWidth = CGFloat(lineWith)
        let linePath4 = UIBezierPath.init()
        let point2 = CGPoint(x: CGFloat(width/2 + lineWith * sqrt(2)/4), y: CGFloat(lightGrayLength + vLenght + lineWith/2 - lineWith * sqrt(2)/4))
        linePath4.move(to: point2)
        linePath4.addLine(to: CGPoint(x: (point2.x - hLength * sqrt(2)/2), y: (point2.y - hLength * sqrt(2)/2)))
        rightLayer.path = linePath4.cgPath
        self.addSublayer(rightLayer)
    }
    
    func begingAnimation(){
        let tailAnimation =  CABasicAnimation.init(keyPath: "strokeEnd")
        tailAnimation.duration = 0.25;
        tailAnimation.fromValue = 1;
        tailAnimation.toValue = 0;
        tailAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        grayLayer.add(tailAnimation, forKey: "key")
        darkLayer.add(tailAnimation, forKey: "key")
        leftLayer.add(tailAnimation, forKey: "key")
        rightLayer.add(tailAnimation, forKey: "key")
    }
}

class PullLoadingView: UIView {

    weak var scrollView : UIScrollView! = nil
    
    var status: PullLoadingStatus! = PullLoadingStatus.stop
    var observedScrollViewOriginalContentInsetTop : CGFloat! = 0
    var isArrowRotation = false
    var arrowLayer : ArrowLayer! = nil
    var circleLayer : LoadingCircleLayer! = nil
    
    init(frame: CGRect,observedScrollView:UIScrollView) {
        super.init(frame: frame)
        scrollView = observedScrollView
        self.observedScrollViewOriginalContentInsetTop = scrollView.contentInset.top
        self.arrowLayer = ArrowLayer.init()
        self.arrowLayer.frame = CGRect(x: self.width/2 - 10, y: self.height - 33, width: 20, height: 20)
        self.arrowLayer.addArrowLayer()
        
        self.circleLayer = LoadingCircleLayer()
        self.circleLayer.frame = CGRect(x: self.width/2 - 10, y: self.height - 33, width: 20, height: 20)
        self.circleLayer.addProgressLayer()

        self.layer.addSublayer(self.arrowLayer)
        self.layer.addSublayer(self.circleLayer)
        self.circleLayer.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeStatus(_ status:PullLoadingStatus){
        self.status = status
        if status == PullLoadingStatus.stop {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
                self.arrowLayer.isHidden = false
            }
            self.stopCircleAnimation()
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.25)
            scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            UIView.commitAnimations()
        } else {
            self.arrowLayer.isHidden = true
            var temp  = self.scrollView.contentOffset.y
            scrollView.contentInset = UIEdgeInsets.init(top: observedScrollViewOriginalContentInsetTop + self.height, left: 0, bottom: 0, right: 0)
            if temp == 0 {
                temp = -self.height
            }
            scrollView.contentOffset = CGPoint(x: 0, y: temp)
            self.beginCircleAnimation()
        }
    }
    
    func scrollViewDidScroll(_ scroll : UIScrollView){
        if self.status != PullLoadingStatus.loading {
            self.arrowRotationAnimation(scroll.contentOffset.y < -64)
        }
    }
    
    func arrowRotationAnimation(_ rotation:Bool) {
        if (self.isArrowRotation != rotation) {
            self.isArrowRotation = rotation
            self.arrowLayer.removeAnimation(forKey: kRotationAnimateKey)
            let theAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
            theAnimation.isRemovedOnCompletion = false
            theAnimation.fillMode = kCAFillModeForwards
            theAnimation.duration = 0.16
            if rotation {
                theAnimation.fromValue = 0
                theAnimation.toValue = -Double.pi
            } else {
                theAnimation.fromValue = -Double.pi
                theAnimation.toValue = 0
            }
            self.arrowLayer.add(theAnimation, forKey: kRotationAnimateKey)
        }
    }
    
    func beginCircleAnimation() {
        self.circleLayer.isHidden = false
        self.circleLayer.beginAnimation()
    }
    
    func stopCircleAnimation() {
        self.circleLayer.isHidden = true
        self.circleLayer.endAnimation()
    }
}
