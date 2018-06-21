//
//  CSRefreshStateHeader.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/20.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import MJRefresh

class CSRefreshStateHeader: MJRefreshStateHeader {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var tempState = MJRefreshState.idle
    var arrowLayer : ArrowLayer! = nil
    var circleLayer : LoadingCircleLayer! = nil
    var arrowView : UIView! = nil
    
    override func placeSubviews() {
        super.placeSubviews()
        if self.arrowView == nil {
            self.arrowLayer = ArrowLayer.init()
            self.arrowLayer.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            self.arrowLayer.addArrowLayer()
            self.arrowView = UIView.init(frame: CGRect(x: self.width/2 - 10, y: self.height - 33, width: 20, height: 20))
            self.arrowView.layer.addSublayer(self.arrowLayer)
            self.addSubview(self.arrowView);
        }

        if self.circleLayer == nil {
            self.circleLayer = LoadingCircleLayer()
            self.circleLayer.frame = CGRect(x: self.width/2 - 10, y: self.height - 33, width: 20, height: 20)
            self.circleLayer.addProgressLayer()
            self.layer.addSublayer(self.circleLayer)
        }
    }
    
    override var state: MJRefreshState {
        get  {
            return self.tempState
        }
        set  {
            if self.tempState == newValue {
                return
            }
            super.state = newValue
            if newValue == MJRefreshState.idle {
                if tempState == MJRefreshState.refreshing {
                    self.arrowView.transform = CGAffineTransform.identity
                    UIView.animate(withDuration: 0.4, animations: {
                        self.circleLayer.opacity = 0;
                    }) { (finish) in
                        if self.tempState != MJRefreshState.idle {
                            return
                        }
                        self.arrowView.isHidden = false
                        self.circleLayer.endAnimation()
                        self.circleLayer.opacity = 0
                    }
                    
                } else {
                    self.arrowView.isHidden = false
                    self.circleLayer.endAnimation()
                    UIView.animate(withDuration: 0.25) {
                        self.arrowView.transform = CGAffineTransform.identity
                    }
                }
            } else if newValue == MJRefreshState.pulling {
                self.arrowView.isHidden = false
                self.circleLayer.endAnimation()
                UIView.animate(withDuration: 0.25) {
                    self.arrowView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
                    
                }
            } else if newValue == MJRefreshState.refreshing {
                self.arrowView.isHidden = true
                self.circleLayer.opacity = 1
                self.circleLayer.beginAnimation()
            }
            self.tempState = newValue
        }
    }
    

}
