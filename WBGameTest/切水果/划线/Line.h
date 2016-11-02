//
//  Line.h
//  Day22Draw
//
//  Created by tarena on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Line : NSObject

@property (nonatomic,retain) UIColor *LColor;
@property (nonatomic,assign) int Width;
@property (nonatomic,retain) NSMutableArray *Ps; 

@end
