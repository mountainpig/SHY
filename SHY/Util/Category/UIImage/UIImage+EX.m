//
//  UIImage+EX.m
//  SHY
//
//  Created by 黄敬 on 2018/6/21.
//  Copyright © 2018年 hj. All rights reserved.
//

#import "UIImage+EX.h"

@implementation UIImage (EX)
+ (UIImage *)cornerRadiusCorverWithWidth:(CGFloat)width color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, width, width));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, [UIScreen mainScreen].scale);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, width, width));
    CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    CGContextEOClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, width, width), [theImage CGImage]);
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImg;
}
@end
