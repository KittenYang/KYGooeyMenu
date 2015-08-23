//
//  MenuLayer.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 15/8/23.
//  Copyright (c) 2015年 Kitten Yang. All rights reserved.
//

#import "MenuLayer.h"
#define OFF 30

@interface MenuLayer ()

@property(nonatomic,assign)CGFloat xAxisPercent;

@end

@implementation MenuLayer

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(id)initWithLayer:(MenuLayer *)layer{
    self = [super initWithLayer:layer];
    if (self) {
        
        self.showDebug = layer.showDebug;
        self.xAxisPercent = layer.xAxisPercent;
    }
    return self;
    
}

+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"xAxisPercent"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx{
    
    CGRect real_rect = CGRectInset(self.frame, OFF,OFF);
    CGFloat offset = real_rect.size.width/ 3.6;
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    CGFloat moveDistance = _xAxisPercent*((real_rect.size.width/2-real_rect.size.width/3.6)/2);
    CGFloat moveDistance = _xAxisPercent*(offset);
    
    CGPoint top_left   =  CGPointMake(center.x-offset-moveDistance, OFF);
    CGPoint top_center =  CGPointMake(center.x-moveDistance, OFF);
    CGPoint top_right  =  CGPointMake(center.x+offset-moveDistance, OFF);
    
    CGPoint right_top    =  CGPointMake(CGRectGetMaxX(real_rect), center.y-offset);
    CGPoint right_center =  CGPointMake(CGRectGetMaxX(real_rect), center.y);
    CGPoint right_bottom =  CGPointMake(CGRectGetMaxX(real_rect), center.y+offset);
    
    CGPoint bottom_left   =  CGPointMake(center.x-offset, CGRectGetMaxY(real_rect));
    CGPoint bottom_center =  CGPointMake(center.x, CGRectGetMaxY(real_rect));
    CGPoint bottom_right  =  CGPointMake(center.x+offset, CGRectGetMaxY(real_rect));
    
    CGPoint left_top    =  CGPointMake(OFF, center.y-offset);
    CGPoint left_center =  CGPointMake(OFF, center.y);
    CGPoint left_bottom =  CGPointMake(OFF, center.y+offset);
    
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:top_center];
    [circlePath addCurveToPoint:right_center controlPoint1:top_right controlPoint2:right_top];
    [circlePath addCurveToPoint:bottom_center controlPoint1:right_bottom controlPoint2:bottom_right];
    [circlePath addCurveToPoint:left_center controlPoint1:bottom_left controlPoint2:left_bottom];
    [circlePath addCurveToPoint:top_center controlPoint1:left_top controlPoint2:top_left];
    [circlePath closePath];
    
    CGContextAddPath(ctx, circlePath.CGPath);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);

    
    if (_showDebug) {
        
        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
        
        [self showPoint:top_left context:ctx];
        [self showPoint:top_center context:ctx];
        [self showPoint:top_right context:ctx];
        
        [self showPoint:right_top context:ctx];
        [self showPoint:right_center context:ctx];
        [self showPoint:right_bottom context:ctx];
        
        [self showPoint:bottom_left context:ctx];
        [self showPoint:bottom_center context:ctx];
        [self showPoint:bottom_right context:ctx];
        
        [self showPoint:left_top context:ctx];
        [self showPoint:left_center context:ctx];
        [self showPoint:left_bottom context:ctx];
        
    }
    
}



-(void)showPoint:(CGPoint)point context:(CGContextRef)ctx{

    NSLog(@"%@",NSStringFromCGPoint(point));
    CGRect rect = CGRectMake(point.x-1, point.y-1, 2, 2);
    CGContextFillRect(ctx, rect);
    
}


@end
