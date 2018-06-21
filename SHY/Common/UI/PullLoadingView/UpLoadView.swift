//
//  UpLoadView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/19.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

enum UpLoadingStatus {
    case stop
    case loading
}

class UpLoadView: UIView {

    var status: UpLoadingStatus! = UpLoadingStatus.stop
    var textLabel : UILabel! = nil
    var circleLayer : LoadingCircleLayer! = nil
    weak var scrollView : UIScrollView! = nil
    
    init(frame: CGRect,observedScrollView:UIScrollView) {
        super.init(frame: frame)
        self.scrollView = observedScrollView
        
        self.addObserver(observedScrollView, forKeyPath: "contentOffset", options: .new, context: nil)
        
        self.textLabel = UILabel.init(frame: CGRect(x: self.width/2 - 19, y: 11, width: 58, height: 11))
        self.textLabel.font = UIFont.systemFont(ofSize: 11)
        self.textLabel.textColor = UIColor.grayThree()
        self.textLabel.text = "内容加载中"
        self.textLabel.isHidden = true
        self.addSubview(self.textLabel)

        self.circleLayer = LoadingCircleLayer()
        self.circleLayer.frame = CGRect(x: self.width/2 - 39, y: 11, width: 11, height: 11)
        self.circleLayer.addProgressLayer()
        self.layer.addSublayer(self.circleLayer)
        self.circleLayer.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeStatus(_ status:UpLoadingStatus){
        if self.status == status {
            return
        }
        self.status = status
        if self.status == UpLoadingStatus.stop {
            self.textLabel.isHidden = true
            self.circleLayer.isHidden = true
            self.circleLayer.endAnimation()
        } else {
            self.textLabel.isHidden = false
            self.circleLayer.isHidden = false
            self.circleLayer.beginAnimation()
        }
    }
    
    func scrollViewDidScroll(_ scroll : UIScrollView){
        self.top = scroll.contentSize.height
        if scroll.contentOffset.y > scroll.contentSize.height - scroll.height {
            self.changeStatus(UpLoadingStatus.loading)
        }
    }
    
    func observeValueForKeyPath(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
     {
        if keyPath == "contentOffset" {
            if let newValue = change?[NSKeyValueChangeKey.newKey] {
                print("\(newValue)")
            }
        }
    }

    deinit {
        self.removeObserver(scrollView, forKeyPath: "contentOffset", context: nil)
        self.circleLayer.endAnimation()
    }

}
