//
//  UIColor+Hex.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/29.
//  Copyright © 2018年 hj. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    static func width(_ width : CGFloat) -> CGSize {
        return CGSize(width: width, height: width)
    }
}

extension CGRect {
    static func width(_ width : CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: width, height: width)
    }
    
    static func size(_ size : CGSize) -> CGRect {
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
}

extension UIImage {
    static func radiusCorver(width: CGFloat,color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize.width(width), false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect.width(width))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIGraphicsBeginImageContextWithOptions(CGSize.width(width), false, UIScreen.main.scale)
        context?.addEllipse(in:CGRect.width(width))
        context?.addRect(CGRect.width(width))
        context?.clip(using: CGPathFillRule.evenOdd)
        context?.draw((image?.cgImage)!, in: CGRect.width(width))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
    
    func corverColor(_ color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect.size(self.size)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -self.size.height)
        context?.saveGState()
        context?.clip(to: rect, mask: self.cgImage!)
        color.set()
        context?.fill(rect)
        context?.restoreGState()
        context?.setBlendMode(CGBlendMode.multiply)
        context?.draw(self.cgImage!, in: rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
    
    //ImageIO
    func resizeIO(size:CGSize) -> UIImage? {

        guard let data = UIImagePNGRepresentation(self) else { return nil }
        
        let maxPixelSize = max(size.width, size.height)
        
        //let imageSource = CGImageSourceCreateWithURL(url, nil)
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        //kCGImageSourceThumbnailMaxPixelSize为生成缩略图的大小。当设置为800，如果图片本身大于800*600，则生成后图片大小为800*600，如果源图片为700*500，则生成图片为800*500
        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        
        let resizedImage = CGImageSourceCreateImageAtIndex(imageSource, 0, options as CFDictionary).flatMap{
            UIImage(cgImage: $0)
        }
        return resizedImage
    }

}
