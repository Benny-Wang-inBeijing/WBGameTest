//
//  CartPlayViewController.m
//  WBGameTest
//
//  Created by wangbo on 16/10/12.
//  Copyright © 2016年 wangbo. All rights reserved.
//

#import "CartPlayViewController.h"

@interface CartPlayViewController ()

@end

@implementation CartPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [v1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:v1];
    
    [v1 setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipover:)];
    [v1 addGestureRecognizer:tap];
    
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    [v2 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:v2];
    
    
    [self ChangePositionView1:v1 View2:v2 duration:0.5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)ChangePositionView1:(UIView *)view1 View2:(UIView *)view2 duration:(float)du{
    
    CGPoint c1 = CGPointMake(view1.center.x, view1.center.y);
    CGPoint c2 = CGPointMake(view2.center.x, view2.center.y);
    
    CGPoint controlP1 = CGPointMake((view1.center.x+view2.center.x)/2.0+(view1.center.y-view2.center.y)/2.0, (view1.center.y+view2.center.y)/2.0-(view1.center.x-view2.center.x)/2.0);
    CGPoint controlP2 = CGPointMake((view1.center.x+view2.center.x)/2.0-(view1.center.y-view2.center.y)/2.0, (view1.center.y+view2.center.y)/2.0+(view1.center.x-view2.center.x)/2.0);
    
    [view1 animationToPosition:c2 controlPoint:controlP2 duration:du];
    [view2 animationToPosition:c1 controlPoint:controlP1 duration:du];
}


-(void)flipover:(UIGestureRecognizer *)ges{
    
    if (ges.view.backgroundColor == [UIColor redColor]) {
        
//        CATransition *transition = [CATransition animation];
//        transition.duration = 1.0;
//        transition.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//        transition.type = @"flip";
//        transition.subtype = kCATransitionFromLeft;
//        [ges.view.layer addAnimation:transition forKey:nil];
//        [ges.view setBackgroundColor:[UIColor blueColor]];
        
        [ges.view setBackgroundColor:[UIColor blueColor]];
        [UIView transitionWithView:ges.view duration:.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        } completion:^(BOOL finished) {
            [ges.view setBackgroundColor:[UIColor redColor]];
            [UIView transitionWithView:ges.view duration:.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            } completion:^(BOOL finished) {
            }];
        }];
    }else{
        [ges.view setBackgroundColor:[UIColor redColor]];
        [UIView transitionWithView:ges.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        } completion:^(BOOL finished) {
        }];
        
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
