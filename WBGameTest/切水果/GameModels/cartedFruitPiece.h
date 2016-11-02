//
//  cartedFruitPiece.h
//  WBGameTest
//
//  Created by wangbo on 16/10/10.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "WBGameItem.h"

@interface cartedFruitPiece : WBGameItem

@property (nonatomic , retain) UIPushBehavior *push;
@property (copy) void (^needDestory)(cartedFruitPiece *item);

@end
