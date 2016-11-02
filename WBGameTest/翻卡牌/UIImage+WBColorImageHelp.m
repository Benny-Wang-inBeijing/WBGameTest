//
//  UIImage+WBColorImageHelp.m
//  xuxian60
//
//  Created by wangbo on 16/11/2.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "UIImage+WBColorImageHelp.h"

@implementation UIImage (WBColorImageHelp)

+(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
