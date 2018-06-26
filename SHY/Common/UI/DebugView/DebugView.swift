//
//  DebugView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/26.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class DebugView: UIView {
    
    let blockTop = 20 + kXtop();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.top = blockTop
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        self.layer.cornerRadius = 3;
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        self.addGestureRecognizer(pan)
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.init(white: 1, alpha: 0.9).cgColor
        layer.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        layer.cornerRadius = 20
        self.layer.addSublayer(layer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panGesture(_ recognizer:UIPanGestureRecognizer) {
        let point = recognizer.translation(in: self.superview)
        let center = recognizer.view!.center
        recognizer.view?.center = CGPoint(x: point.x + center.x, y: point.y + center.y)
        recognizer.setTranslation(CGPoint.zero, in: self.superview)
        self.adjustPosition()
        if recognizer.state == UIGestureRecognizerState.ended {
            self.adjustEndPosition()
        }
    }
    
     func adjustPosition() {
        if self.top < blockTop {
            self.top = blockTop
        }
        if self.left < 5 {
            self.left = 5
        }
        if self.right > kScreenWidth - 5 {
            self.right = kScreenWidth - 5
        }
        if self.bottom > kScreenHeight - 5 {
            self.bottom = kScreenHeight - 5
        }
    }
    
    func adjustEndPosition() {
        let center = self.center
        let leftSpace = center.x
        let rightSpace = kScreenWidth - center.x
        let topSpace = center.y
        let bottomSpace = kScreenHeight - center.y
        let min = CGFloat.minimum(CGFloat.minimum(leftSpace, rightSpace), CGFloat.minimum(topSpace, bottomSpace))
        UIView.animate(withDuration: 0.25) {
            switch min {
            case leftSpace  :
                self.left = 5
                break
            case rightSpace  :
                self.left = kScreenWidth - self.width - 5
                break
            case topSpace  :
                self.top = self.blockTop
                break
            case bottomSpace :
                self.top = kScreenHeight - self.height - 5
                break
            default :
                break
            }
        }
    }
    
}
