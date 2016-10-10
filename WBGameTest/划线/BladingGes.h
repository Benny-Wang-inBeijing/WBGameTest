//
//  BladingGes.h
//  RedSnow
//
//  Created by wangbo on 16/9/29.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
//@interface Line : NSObject
//
//@property (nonatomic,retain) UIColor *LColor;
//@property (nonatomic,assign) int Width;
//@property (nonatomic,retain) NSMutableArray *Ps;
//
//@end


@interface BladingGes : UIView

@property (copy) void (^GesPoint)(CGPoint p);

-(void)setBackgroundImage:(UIImage *)image;

@end
