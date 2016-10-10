//
//  ViewController.m
//  WBGameTest
//
//  Created by wangbo on 16/10/10.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "ViewController.h"
#import "BladingGes.h"
#import "FruitToCart.h"
#import "cartedFruitPiece.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIDynamicAnimator *theAnimator;
    UIGravityBehavior *gravityBehaviour;
    NSMutableArray *items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor blackColor]];
    BladingGes *dr = [[BladingGes alloc] initWithFrame:self.view.frame];
    [dr setBackgroundColor:[UIColor clearColor]];
    //    [dr setBackgroundImage:[UIImage imageNamed:@"我的-上滑-1.jpg"]];
    [self.view addSubview:dr];
    
    //手势刀刃的回调，在这个方法里做页面上所有水果item的碰撞检测
    [dr setGesPoint:^(CGPoint p) {
        @synchronized (items) {
            for (int i = 0; i<items.count; i++) {
                FruitToCart *f = [items objectAtIndex:i];
                [f checkIn:p];
            }
//            for (FruitToCart *f in items) {
//                
//            }
        }
    }];
    
    [self startGame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)startGame{
    items = [NSMutableArray array];
    //    [self.view addSubview:self.begainGameView];
    
    // Do any additional setup after loading the view.
    theAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    gravityBehaviour = [[UIGravityBehavior alloc] init];
    [theAnimator addBehavior:gravityBehaviour];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (true){
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *type;
                switch (arc4random()%3) {
                    case 0:
                        type = @"柠檬";
                        break;
                    case 1:
                        type = @"柠檬";
                        break;
                    case 2:
                        type = @"火龙果";
                        break;
                    default:
                        break;
                }
                
                
                FruitToCart *f = [[FruitToCart alloc] initWithFrame:CGRectMake(arc4random()%(int)(Screenwith-200)+100, self.view.frame.size.height, [type isEqualToString:@"火龙果"]?70:50, [type isEqualToString:@"火龙果"]?70:50) Params:@{@"duration":@"3",@"type":type}];
                [f startShow];
                
                [items addObject:f];
                
//                __block typeof (FruitToCart) *weakF = f;
 
                [f setNeedDestory:^(FruitToCart *item) {
                    @synchronized (items) {
                        [items removeObject:item];
                        [gravityBehaviour removeItem:item];
                        [theAnimator removeBehavior:theAnimator.behaviors[1]];//移除最早的一个pushbehaviour
                    }
                }];
                
                [f setTouched:^(FruitToCart *item) {
                    [item triggerAction];
                }];
                
                //因为碎片也要加入到重力系统中，所以这个事件在vc中写了
                [f setTriggerAnimation:^(WBGameItem *sv, void (^complish)(BOOL complish)) {
                    [self itemcartToPieces:(FruitToCart*)sv];
                    complish(YES);
                }];
                
                
                [self.view insertSubview:f atIndex:0];
                
                [gravityBehaviour addItem:f];
                
                UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[f] mode:UIPushBehaviorModeInstantaneous];
                
                
                float fx = 0.1*(arc4random()%6-3.0);
                float fy = (float)(-1.7-0.1*(arc4random()%9));
                
                if ([type isEqualToString:@"火龙果"]) {
                    fx = fx*1.7;
                    fy = fy*1.7;
                }
                
                [push setPushDirection:CGVectorMake(fx, fy)];
                
                [theAnimator addBehavior:push];
            });
            
            [NSThread sleepForTimeInterval:0.1*(arc4random()%9)];
        }
        
    });

}

-(void)itemcartToPieces:(FruitToCart *)item {
    
    cartedFruitPiece *pis1 = [[cartedFruitPiece alloc] initWithFrame:CGRectMake(item.frame.origin.x-item.frame.size.width/4, item.frame.origin.y, item.frame.size.width, item.frame.size.height) Params:@{@"duration":@"3",@"piece":@"left",@"type":[item.params valueForKey:@"type"]}];
    [pis1 startShow];
    
    [self.view insertSubview:pis1 atIndex:0];
    
    [gravityBehaviour addItem:pis1];
    UIPushBehavior *push1 = [[UIPushBehavior alloc] initWithItems:@[pis1] mode:UIPushBehaviorModeInstantaneous];
    [push1 setPushDirection:CGVectorMake(-0.1, 0)];
    [theAnimator addBehavior:push1];
    
    pis1.push = push1;
    [pis1 setNeedDestory:^(cartedFruitPiece *item) {
        [theAnimator removeBehavior:item.push];
        [gravityBehaviour removeItem:item];
    }];
    
    
    cartedFruitPiece *pis2 = [[cartedFruitPiece alloc] initWithFrame:CGRectMake(item.frame.origin.x+item.frame.size.width/4, item.frame.origin.y, item.frame.size.width, item.frame.size.height) Params:@{@"duration":@"3",@"piece":@"right",@"type":[item.params valueForKey:@"type"]}];
    [pis2 startShow];
//    UIView *pis2 = [[UIView alloc] initWithFrame:CGRectMake(item.frame.origin.x+item.frame.size.width/2, item.frame.origin.y, item.frame.size.width/2, item.frame.size.height)];
//    [pis2 setBackgroundColor:[UIColor greenColor]];
    
    [self.view insertSubview:pis2 atIndex:0];
    
    [gravityBehaviour addItem:pis2];
    UIPushBehavior *push2 = [[UIPushBehavior alloc] initWithItems:@[pis2] mode:UIPushBehaviorModeInstantaneous];
    [push2 setPushDirection:CGVectorMake(0.1, 0)];
    [theAnimator addBehavior:push2];
    
    pis2.push = push2;
    [pis2 setNeedDestory:^(cartedFruitPiece *item) {
        [theAnimator removeBehavior:item.push];
        [gravityBehaviour removeItem:item];
    }];
}



@end
