//
//  FlipCard.m
//  WBGameTest
//
//  Created by wangbo on 16/11/1.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "FlipCard.h"
#import "UIView+WBAnimationHelp.h"

@implementation FlipCard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化工作
        
    }
    return self;
}

-(void)setFrontImage:(UIImage *)frontImage{
    _frontImage = frontImage;
    if (_isFront) {
        [self setImage:frontImage];
    }
}

-(void)setBackImage:(UIImage *)backImage{
    _backImage = backImage;
    if (!_isFront) {
        [self setImage:backImage];
    }
}


-(void)flipover{
    self.userInteractionEnabled = NO;
    if (_isFront) {
        [self setImage:_backImage];
        [self CommitflipAnimationFromLeftComplish:^{
            _isFront = NO;
        }];
    }else{
        [self setImage:_frontImage];
        [self CommitflipAnimationFromLeftComplish:^{
            _isFront = YES;
            if (_didTap) {
                _didTap(_data);
            }
        }];
    }
}

-(void)overLook{
    [self setImage:_frontImage];
    [self CommitflipAnimationFromLeftComplish:^{
        
        [self setImage:_backImage];
        [self CommitflipAnimationFromLeftComplish:^{
           
        }];
    }];
}


-(void)startTap{
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipover)];
    [self addGestureRecognizer:tap];
}

-(void)finishTap{
    self.userInteractionEnabled = NO;
}

@end
