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

}
