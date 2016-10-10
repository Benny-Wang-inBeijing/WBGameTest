//
//  BladingGes.m
//  RedSnow
//
//  Created by wangbo on 16/9/29.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "BladingGes.h"

//@class Line;

@implementation BladingGes
{
    Line *currentDrawingLine;
    NSMutableArray *lines;
    NSTimer *timer;
    
    //点之间增加判断点
    CGPoint previousPoint;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
//    if (lines.count>0) {
//        for (int j=0; j<lines.count; j++) {
//            Line *cl = [lines objectAtIndex:j];
//            
//            int needabsW = j-(int)lines.count/2;
//            CGContextSetLineWidth(context, cl.Width-abs(needabsW)/2);
//            CGContextSetStrokeColorWithColor(context, cl.LColor.CGColor);
//            NSArray *ps = cl.Ps;
//            
//            for (int i=0; i<ps.count; i++) {
//                CGPoint p = [((NSValue*)[ps objectAtIndex:i]) CGPointValue];
//                if (i==0) {
//                    CGContextMoveToPoint(context, p.x, p.y);
//                }else{
//                    
//                    if (j>0) {//不是第一条线
//                        NSArray *points = ((Line *)[lines objectAtIndex:j-1]).Ps;
//                        CGPoint prexy = CGPointMake([((NSValue*)[points lastObject]) CGPointValue].x-[((NSValue*)[points firstObject]) CGPointValue].x, [((NSValue*)[points lastObject]) CGPointValue].y-[((NSValue*)[points firstObject]) CGPointValue].y);
//                        CGPoint curxy = CGPointMake([((NSValue*)[ps lastObject]) CGPointValue].x-[((NSValue*)[ps firstObject]) CGPointValue].x, [((NSValue*)[ps lastObject]) CGPointValue].y-[((NSValue*)[ps firstObject]) CGPointValue].y);
//                        
//                        CGPoint p0 = [((NSValue*)[ps objectAtIndex:0]) CGPointValue];
//                        CGPoint midPoint =
////                        CGPointMake(p.x+0.5*curxy.x+0.2*prexy.x, p.y+0.5*curxy.y+0.2*prexy.y);
//                        CGPointMake((p0.x + p.x)/2.0, (p0.y + p.y)/2.0);
//                        
//                        CGContextAddLineToPoint(context, midPoint.x, midPoint.y);
//                    }else
//                    
//                    CGContextAddLineToPoint(context, p.x, p.y);
//                }
//            }
//
//            CGContextStrokePath(context);
//        }
//    }
    //画一条线
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (lines.count>0) {
        for (int j=0; j<lines.count; j++) {
            Line *cl = [lines objectAtIndex:j];
            NSArray *ps = cl.Ps;
            
            CGPoint pp = [((NSValue*)[ps objectAtIndex:0]) CGPointValue];
            CGPoint cp = [((NSValue*)[ps objectAtIndex:1]) CGPointValue];
            if (j == 0) {
                [path moveToPoint:pp];
            }
            [path addQuadCurveToPoint:midpoint(pp, cp) controlPoint:pp];
        }
        [path setLineWidth:3.0f];
        [path stroke];
    }
}

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (!lines) {
        lines = [[NSMutableArray alloc]init];
    }
    UITouch *touch = touches.anyObject;
    CGPoint p = [touch locationInView:self];
    
    //设置之前点
    previousPoint = p;
    
    currentDrawingLine = [self newLineWithBeginPoint:p];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endblade];
        }
    );
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint p = [touch locationInView:self];
    NSValue *pvalue = [NSValue valueWithCGPoint:p];
    [currentDrawingLine.Ps addObject:pvalue];
    [lines addObject:currentDrawingLine];
    
    currentDrawingLine = [self newLineWithBeginPoint:p];
    
    if (lines.count>10) {
        [lines removeObjectAtIndex:0];
    }
    
    
    //回调
    if (self.GesPoint) {
        CGPoint p1 = CGPointMake(p.x+(previousPoint.x-p.x)/3.0, p.y+(previousPoint.y-p.y)/3.0);
        CGPoint p2 = CGPointMake(p.x+(previousPoint.x-p.x)/3.0*2, p.y+(previousPoint.y-p.y)/3.0*2);
        self.GesPoint(p1);
        self.GesPoint(p2);
        self.GesPoint(p);
    }
    
    //设置之前点
    previousPoint = p;
    
    [self setNeedsDisplay];
   
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endblade];
}

-(void)endblade{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (!timer) {
            timer = [NSTimer timerWithTimeInterval:0.001f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        }
        //将定时器添加到runloop中
        if (timer) {
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] run];
        }
        
    });
}


-(void)timerAction:(NSTimer *)timerc{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (lines.count>0) {
            [lines removeObjectAtIndex:0];
            [self setNeedsDisplay];
        }else{
            [timerc invalidate];
            timer = nil;
        }
    });
}

-(Line *)newLineWithBeginPoint:(CGPoint)point{
    Line *l = [[Line alloc] init];
    l.LColor = [UIColor whiteColor];
    l.Width = 3;
    l.Ps = [NSMutableArray array];
    NSValue *pvalue = [NSValue valueWithCGPoint:point];
    [l.Ps addObject:pvalue];
    return l;
}


-(void)setBackgroundImage:(UIImage *)image{
    
    UIImage *background = [self imageByScalingToSize:self.frame.size orImage:image];
    
    [self setBackgroundColor:[UIColor colorWithPatternImage:background]];
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize orImage:(UIImage *)image
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    return newImage ;
}

@end
