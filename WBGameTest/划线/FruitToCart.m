//
//  FruitToCart.m
//  RedSnow
//
//  Created by wangbo on 16/9/30.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "FruitToCart.h"

@implementation FruitToCart

-(instancetype)initWithFrame:(CGRect)frame Params:(id)parameters{
    self = [super initWithFrame:frame Params:parameters];
    if (self) {
        //初始化
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [iv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[parameters valueForKey:@"type"]]]];
        [self addSubview:iv];
        
        [self setBeginAnimation:^(WBGameItem *sv, void (^complish)(BOOL complish)) {
            //无初始动画
            complish(YES);
        }];
        
        [self setLifecircleMotion:^(WBGameItem *sv, NSInteger time, void (^complish)(BOOL)) {
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 0.1*(arc4random()%40-20.0) ];
            rotationAnimation.duration = 3.0;
            rotationAnimation.cumulative = YES;
            rotationAnimation.repeatCount = 10;
            
            [sv.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                complish(YES);
            });
        }];
        
        [self setTriggerAnimation:^(WBGameItem *sv, void (^complish)(BOOL complish)) {
            complish(YES);
        }];
        
        [self setEndAnimation:^(WBGameItem *sv, void (^complish)(BOOL complish)) {
            complish(YES);
        }];
    }
    return self;
}


-(BOOL)checkIn:(CGPoint)position Force:(CGPoint)force{
    
    if (position.x>self.frame.origin.x && position.x<self.frame.origin.x+self.frame.size.width) {
        if (position.y>self.frame.origin.y && position.y<self.frame.origin.y+self.frame.size.height) {
            ///受力位置
            if (self.touched) {
                self.cutForce = force;
                self.touched(self,force);
                self.touched = nil;//确保之执行一次
            }
            return YES;
        }
    }
    return NO;
}

-(void)destory{
    if (self.needDestory) {
        self.needDestory(self);
    }
    //销毁事件，需要做什么操作或者回调再定义
    [self removeFromSuperview];
    self.touched = nil;
    self.BeginAnimation = nil;
    self.LifecircleMotion = nil;
    self.triggerAnimation = nil;
    self.EndAnimation = nil;
    [self setUserInteractionEnabled:NO];
}


//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch * touch = [[event allTouches] anyObject];
//    CGPoint touchLocation = [touch locationInView:self];
//    if (touchLocation.x>0 && touchLocation.x<self.frame.size.width) {
//        if (touchLocation.y>0 && touchLocation.y<self.frame.size.height) {
//            NSLog(@"hit");
//        }
//    }
//    
//}
//
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    return YES;
//}


@end
