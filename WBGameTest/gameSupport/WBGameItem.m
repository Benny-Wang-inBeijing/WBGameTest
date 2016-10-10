//
//  WBGameItem.m
//  RedSnow
//
//  Created by wangbo on 16/9/13.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "WBGameItem.h"
#import <objc/runtime.h>

@interface WBGameItem()

@property (nonatomic , assign) BOOL isEnding;//如果触发了事件，那么，到时间的结束触发就不需要执行了

@end



#define durationTime 3

@implementation WBGameItem

-(instancetype)initWithFrame:(CGRect)frame Params:(id)parameters{
    self = [super initWithFrame:frame];
    if (self) {
        objc_setAssociatedObject(self, @"params", parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
       
#warning - 示例，需要改的地方，或是由子类继承处理的地方
        /**
         *  这里只是一个示例，具体初始化内容由parameters中的参数决定。
         如果说还想更进一步的话，初始化方法应该由子类继承，并且将不同的初始化方法放到不同的子类中
         */
        self.userInteractionEnabled = YES;
    }
    return self;
}

/**
*   懒加载方法，配合params使用
*/
-(id)params{
    return objc_getAssociatedObject(self, @"params");
}

#pragma mark - 开始事件，由外部使用
-(void)startShow{
    if (self.BeginAnimation) {
        self.BeginAnimation(self,^(BOOL complish){
            if (complish) {
                [self NeedMotionAction];
            }else{
                ///处理失败的情况,这里不写了
            }
        });
    }
}

#pragma mark - 内部开始运动事件
- (void)NeedMotionAction{
    if (self.LifecircleMotion) {
        int duration = durationTime;//默认值3秒
        if ([self.params valueForKey:@"duration"]) {
            duration = [[self.params valueForKey:@"duration"] intValue];
        }
        self.LifecircleMotion(self,duration,^(BOOL complish){
            if (complish) {
                [self NeedEndAndRelease];
            }else{
                ///处理失败的情况,这里不写了
            }
        });
    }
}

#pragma mark - 触发事件，由外部使用
-(void)triggerAction{
    if (self.triggerAnimation) {
        self.triggerAnimation(self,^(BOOL complish){
            if (complish) {
                self.isEnding = YES;//控制结束
                [self destory];
            }else{
                ///处理失败的情况,这里不写了
            }
        });
    }
}

#pragma mark - 内部结束事件
-(void)NeedEndAndRelease{
    if (!self.isEnding) {//未经由触发器触发
        if (self.EndAnimation) {
            self.EndAnimation(self,^(BOOL complish){
                if (complish) {
                    [self destory];
                }else{
                    ///处理失败的情况,这里不写了
                }
            });
        }
    }
}


#pragma mark - 销毁
-(void)destory{
    //销毁事件，需要做什么操作或者回调再定义
}

@end
