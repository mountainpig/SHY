//
//  ImageZoomScrollView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/6.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

protocol ImageZoomScrollViewProtocol : NSObjectProtocol{
    func tapClick(index : Int)
    func changeAlaph(_ alaph: CGFloat)
}

class ImageZoomScrollView: UIView,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    var startPoint : CGPoint?
    var startCenter : CGPoint?
    var firstTouchPoint : CGPoint?
    var isMoving = false
    var scrollView : UIScrollView! = nil
    var imageView : UIImageView! = nil
    var index : Int! = 0
    weak var delegate : ImageZoomScrollViewProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView = UIScrollView.init(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        scrollView.delegate = self
        self.addSubview(scrollView)
        imageView = UIImageView.init(frame: scrollView.bounds)
        scrollView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        let tap : UITapGestureRecognizer! = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        let doubleTap : UITapGestureRecognizer! = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapClick(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        tap.require(toFail: doubleTap)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
        self.addjustZoomScale()
    }
    
    @objc func tapClick(_ tap : UITapGestureRecognizer) {
        self.delegate?.tapClick(index: self.index)
    }

    @objc func doubleTapClick(_ tap : UITapGestureRecognizer) {
        if self.scrollView.zoomScale <= 1.0 {
            let center : CGPoint! = tap.location(in: tap.view)
            self.scrollView.zoom(to: CGRect(x: center.x - 0.5, y: center.y - 0.5, width: 1, height: 1), animated: true)
        } else {
            self.scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    @objc func panGesture(_ recognizer:UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        switch recognizer.state {
        case .began:
            self.startPoint = location
            self.startCenter = self.imageView.center
            self.isMoving = true
            break
        case .changed:
            if location.y < self.startPoint!.y && !self.isMoving {
                return
            }
            var offset = fminf(Float((1 - location.y/self.height) * 2), 1)
            let alpha = CGFloat(fmaxf(offset,0))
            offset = fmaxf(offset,0.5)
            self.imageView.transform = CGAffineTransform.init(translationX: location.x - self.startPoint!.x, y: location.y - self.startPoint!.y).scaledBy(x: CGFloat(offset),y: CGFloat(offset))
            self.delegate?.changeAlaph(alpha)
            break
        case .ended,.cancelled:
            self.isMoving = false
            UIView.animate(withDuration: 0.25) {
                self.imageView.transform = CGAffineTransform.init(translationX: 0, y: 0).scaledBy(x: 1,y: 1)
                self.delegate?.changeAlaph(1)
            }
            break
        default:
            break
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) {
            self.firstTouchPoint = touch.location(in: self)
        }
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        let touchPoint = gestureRecognizer.location(in: self)
        let dirTop = self.firstTouchPoint!.y - touchPoint.y
        if dirTop > -10 && dirTop < 10 {
            return false
        }
        let dirLift = self.firstTouchPoint!.x - touchPoint.x
        if dirLift > -10 && dirLift < 10 {
//            return false
        }
        
        return true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: - scrollView delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scrollView.setZoomScale(scale, animated: true)
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let contentSize = scrollView.contentSize
        let imgFrame = imageView.frame
        let scrollViewFrame = scrollView.frame
        var centerPoint = CGPoint(x: contentSize.width/2, y: contentSize.height/2)
        if imgFrame.width <= scrollViewFrame.width {
            centerPoint.x = scrollViewFrame.width/2
        }
        if imgFrame.height <= scrollViewFrame.height {
            centerPoint.y = scrollViewFrame.height/2
        }
        imageView.center = centerPoint
    }
    
    func addjustZoomScale() {
        self.scrollView.maximumZoomScale = 3;
        self.scrollView.minimumZoomScale = 1;
    }
}
