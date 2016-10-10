//
//  cartedFruitPiece.m
//  WBGameTest
//
//  Created by wangbo on 16/10/10.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "cartedFruitPiece.h"

@implementation cartedFruitPiece

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame Params:(id)parameters{
    self = [super initWithFrame:frame Params:parameters];
    if (self) {
        //初始化
        if ([[parameters valueForKey:@"piece"] isEqualToString:@"left"]) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [iv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@1.png",[parameters valueForKey:@"type"]]]];
            [self addSubview:iv];
        }else{
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [iv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@2.png",[parameters valueForKey:@"type"]]]];
            [self addSubview:iv];
        }
        
        
        [self setBeginAnimation:^(WBGameItem *sv, void (^complish)(BOOL complish)) {
            //无初始动画
            complish(YES);
        }];
        
        [self setLifecircleMotion:^(WBGameItem *sv, NSInteger time, void (^complish)(BOOL)) {
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            if ([[parameters valueForKey:@"piece"] isEqualToString:@"left"]) {
                rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 0.1*(arc4random()%40+20) ];
            }else{
                rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * -0.1*(arc4random()%40+20) ];
            }
            
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

-(void)destory{
    if (self.needDestory) {
        self.needDestory(self);
    }
    //销毁事件，需要做什么操作或者回调再定义
    [self removeFromSuperview];
    self.BeginAnimation = nil;
    self.LifecircleMotion = nil;
    self.triggerAnimation = nil;
    self.EndAnimation = nil;
    self.push = nil;
    [self setUserInteractionEnabled:NO];
}

@end
