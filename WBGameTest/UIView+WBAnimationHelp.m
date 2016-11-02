//
//  UIView+WBAnimationHelp.m
//  WBGameTest
//
//  Created by wangbo on 16/10/12.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "UIView+WBAnimationHelp.h"

@implementation UIView (WBAnimationHelp)


-(void)animationToPosition:(CGPoint)position controlPoint:(CGPoint)controlPoint duration:(float)duration{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = duration;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    UIBezierPath *curvedPath;
    curvedPath= [UIBezierPath bezierPath];
    
    [curvedPath moveToPoint:self.center];

    [curvedPath addCurveToPoint:position
                   controlPoint1:self.center
                   controlPoint2:controlPoint];
    
    pathAnimation.path = curvedPath.CGPath;
    
    [self.layer addAnimation:pathAnimation forKey:nil];
    [self setCenter:position];
}


-(void)CommitflipAnimationFromLeftComplish:(void (^)())complish{
    [UIView transitionWithView:self duration:0.25 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    } completion:^(BOOL finished) {
        if (complish) {
            complish();
        }
    }];
}

-(void)CommitflipAnimationFromRightComplish:(void (^)())complish{
    [UIView transitionWithView:self duration:0.25 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
    } completion:^(BOOL finished) {
        if (complish) {
            complish();
        }
    }];
}

@end
