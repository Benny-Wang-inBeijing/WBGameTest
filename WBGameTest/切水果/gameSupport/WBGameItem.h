//
//  WBGameItem.h
//  RedSnow
//
//  Created by wangbo on 16/9/13.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WBGameItem : UIView

///开始动画
@property (copy) void(^BeginAnimation)(WBGameItem *sv, void(^complish)(BOOL complish));
- (void)setBeginAnimation:(void (^)(WBGameItem *sv, void (^complish)(BOOL complish)))BeginAnimation;

///过程动作
@property (copy) void(^LifecircleMotion)(WBGameItem *sv,NSInteger time,void(^complish)(BOOL complish));
- (void)setLifecircleMotion:(void (^)(WBGameItem *sv, NSInteger time, void (^complish)(BOOL complish)))LifecircleMotion;
///触发动画
@property (copy) void(^triggerAnimation)(WBGameItem *sv,void(^complish)(BOOL complish));
- (void)setTriggerAnimation:(void (^)(WBGameItem *sv, void (^complish)(BOOL complish)))triggerAnimation;
///结束动画
@property (copy) void(^EndAnimation)(WBGameItem *sv,void(^complish)(BOOL complish));
- (void)setEndAnimation:(void (^)(WBGameItem *sv, void (^complish)(BOOL complish)))EndAnimation;



//参数
-(id)params;

/**
 *  @bref 初始化方法，parameters存放具体参数数据
 *  @param parameters 运动时间duration，必要条件
 */
-(instancetype)initWithFrame:(CGRect)frame Params:(id)parameters;

/**
 *  开始单元的动作
 */
-(void)startShow;

/**
 *  触发事件，该事件是由外部调用的
 */
-(void)triggerAction;

/**
 *  销毁方法
 */
- (void)destory;



@end
