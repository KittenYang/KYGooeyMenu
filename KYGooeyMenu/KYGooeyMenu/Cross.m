//
//  Cross.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/25/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "Cross.h"

@implementation Cross


- (void)drawRect:(CGRect)rect {
//    //// Rounded Rectangle Drawing
//    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(self.center.x-4,0, 8, self.frame.size.height) cornerRadius: 4];
//    [[UIColor blackColor] setFill];
//    [roundedRectanglePath fill];
//    [[UIColor blackColor] setStroke];
//    roundedRectanglePath.lineWidth = 1;
//    [roundedRectanglePath stroke];
//    
//    
//    //// Rounded Rectangle 2 Drawing
//    UIBezierPath* roundedRectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, self.center.y -4 , self.frame.size.width, 8) cornerRadius: 4];
//    [[UIColor blackColor] setFill];
//    [roundedRectangle2Path fill];
//    [[UIColor blackColor] setStroke];
//    roundedRectangle2Path.lineWidth = 1;
//    [roundedRectangle2Path stroke];

    
    [super drawRect:rect];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 9.0f;
    CGFloat inset  = lineWidth/2;
    
    CGPathMoveToPoint(path, nil, rect.size.width/2, inset);
    CGPathAddLineToPoint(path, nil, rect.size.width/2, rect.size.height-inset);
    CGPathMoveToPoint(path, nil, inset, rect.size.height/2);
    CGPathAddLineToPoint(path, nil, rect.size.width-inset, rect.size.height/2);
    
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
}


@end
