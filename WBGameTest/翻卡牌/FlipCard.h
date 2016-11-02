//
//  FlipCard.h
//  WBGameTest
//
//  Created by wangbo on 16/11/1.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipCard : UIImageView
//数据
@property (nonatomic , retain)NSDictionary *data;
//正反面的图片
@property (nonatomic , retain)UIImage *frontImage;
@property (nonatomic , retain)UIImage *backImage;
//当前状态
@property (nonatomic , assign)BOOL isFront;

//点击回调
@property (copy) void (^didTap)(NSDictionary *data);
/**
 *  方法，用来翻页
 */
//-(void)flipover;

/**
 *  方法，用来开始点击,还有结束
 */
-(void)startTap;
-(void)finishTap;


/**
 *  方法，用来在来的一瞬间展示一下
 */
-(void)overLook;

@end
