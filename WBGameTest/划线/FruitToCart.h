//
//  FruitToCart.h
//  RedSnow
//
//  Created by wangbo on 16/9/30.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "WBGameItem.h"

@interface FruitToCart : WBGameItem

@property (copy) void (^touched)(FruitToCart *item);
@property (copy) void (^needDestory)(FruitToCart *item);

-(BOOL)checkIn:(CGPoint)position;

@end
