//
//  FruitToCart.h
//  RedSnow
//
//  Created by wangbo on 16/9/30.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "WBGameItem.h"

@interface FruitToCart : WBGameItem

@property (copy) void (^touched)(FruitToCart *item,CGPoint force);
@property (copy) void (^needDestory)(FruitToCart *item);

@property (nonatomic , assign)CGPoint cutForce;

//-(BOOL)checkIn:(CGPoint)position;
-(BOOL)checkIn:(CGPoint)position Force:(CGPoint)force;
@end
