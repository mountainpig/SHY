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
}

class ImageZoomScrollView: UIView,UIScrollViewDelegate {

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
        scrollView.addGestureRecognizer(tap)
        let doubleTap : UITapGestureRecognizer! = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapClick(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        tap.require(toFail: doubleTap)
        
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
