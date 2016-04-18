//
//  MenuLayer.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 15/8/23.
//  Copyright (c) 2015年 Kitten Yang. All rights reserved.
//

#import "MenuLayer.h"
const CGFloat OFF = 30;

@interface MenuLayer ()
@end

@implementation MenuLayer

- (id)initWithLayer:(MenuLayer *)layer {
  self = [super initWithLayer:layer];
  if (self) {
    //...在这里拷贝layer的所有property
    self.showDebug = layer.showDebug;
    self.xAxisPercent = layer.xAxisPercent;
    self.animState = layer.animState;
  }
  return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
  if ([key isEqualToString:@"xAxisPercent"]) {
    return YES;
  }
  return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
  CGRect real_rect = CGRectInset(self.frame, OFF, OFF);
  CGFloat offset = real_rect.size.width / 3.6;
  CGPoint center =
      CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

  CGFloat moveDistance_1;
  CGFloat moveDistance_2;
  CGPoint top_left;
  CGPoint top_center;
  CGPoint top_right;

  if (_animState == STATE1) {
    moveDistance_1 = _xAxisPercent * (real_rect.size.width / 2 - offset) / 2;
    top_left = CGPointMake(center.x - offset - moveDistance_1 * 2, OFF);
    top_center = CGPointMake(center.x - moveDistance_1, OFF);
    top_right = CGPointMake(center.x + offset, OFF);
  } else if (_animState == STATE2) {
    CGFloat hightFactor;
    if (_xAxisPercent >= 0.2) {
      hightFactor = 1 - _xAxisPercent;
    } else {
      hightFactor = _xAxisPercent;
    }
    moveDistance_1 = (real_rect.size.width / 2 - offset) / 2;
    moveDistance_2 = _xAxisPercent * (real_rect.size.width / 3);
    top_left = CGPointMake(
        center.x - offset - moveDistance_1 * 2 + moveDistance_2, OFF);
    top_center = CGPointMake(center.x - moveDistance_1 + moveDistance_2, OFF);
    top_right = CGPointMake(center.x + offset + moveDistance_2, OFF);
  } else if (_animState == STATE3) {
    moveDistance_1 = (real_rect.size.width / 2 - offset) / 2;
    moveDistance_2 = (real_rect.size.width / 3);
    CGFloat gooeyDis_1 =
        _xAxisPercent * (center.x - offset - moveDistance_1 * 2 +
                         moveDistance_2 - (center.x - offset));
    CGFloat gooeyDis_2 = _xAxisPercent * (center.x - moveDistance_1 +
                                          moveDistance_2 - (center.x));
    CGFloat gooeyDis_3 = _xAxisPercent * (center.x + offset + moveDistance_2 -
                                          (center.x + offset));

    top_left = CGPointMake(center.x - offset - moveDistance_1 * 2 +
                               moveDistance_2 - gooeyDis_1,
                           OFF);
    top_center = CGPointMake(
        center.x - moveDistance_1 + moveDistance_2 - gooeyDis_2, OFF);
    top_right =
        CGPointMake(center.x + offset + moveDistance_2 - gooeyDis_3, OFF);
  }

  // right
  CGPoint right_top = CGPointMake(CGRectGetMaxX(real_rect), center.y - offset);
  CGPoint right_center = CGPointMake(CGRectGetMaxX(real_rect), center.y);
  CGPoint right_bottom =
      CGPointMake(CGRectGetMaxX(real_rect), center.y + offset);
  // bottom
  CGPoint bottom_left =
      CGPointMake(center.x - offset, CGRectGetMaxY(real_rect));
  CGPoint bottom_center = CGPointMake(center.x, CGRectGetMaxY(real_rect));
  CGPoint bottom_right =
      CGPointMake(center.x + offset, CGRectGetMaxY(real_rect));
  // left
  CGPoint left_top = CGPointMake(OFF, center.y - offset);
  CGPoint left_center = CGPointMake(OFF, center.y);
  CGPoint left_bottom = CGPointMake(OFF, center.y + offset);

  UIBezierPath *circlePath = [UIBezierPath bezierPath];
  [circlePath moveToPoint:top_center];
  [circlePath addCurveToPoint:right_center
                controlPoint1:top_right
                controlPoint2:right_top];
  [circlePath addCurveToPoint:bottom_center
                controlPoint1:right_bottom
                controlPoint2:bottom_right];
  [circlePath addCurveToPoint:left_center
                controlPoint1:bottom_left
                controlPoint2:left_bottom];
  [circlePath addCurveToPoint:top_center
                controlPoint1:left_top
                controlPoint2:top_left];
  [circlePath closePath];

  CGContextAddPath(ctx, circlePath.CGPath);
  CGContextSetFillColorWithColor(
      ctx,
      [UIColor colorWithRed:29.0 / 255.0 green:163.0 / 255.0 blue:1 alpha:1]
          .CGColor);
  CGContextFillPath(ctx);

  if (_showDebug) {
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    // top
    [self showPoint:top_left context:ctx];
    [self showPoint:top_center context:ctx];
    [self showPoint:top_right context:ctx];
    // right
    [self showPoint:right_top context:ctx];
    [self showPoint:right_center context:ctx];
    [self showPoint:right_bottom context:ctx];
    // bottom
    [self showPoint:bottom_left context:ctx];
    [self showPoint:bottom_center context:ctx];
    [self showPoint:bottom_right context:ctx];
    // left
    [self showPoint:left_top context:ctx];
    [self showPoint:left_center context:ctx];
    [self showPoint:left_bottom context:ctx];
  }
}

#pragma mark - help method

- (void)showPoint:(CGPoint)point context:(CGContextRef)ctx {
  NSLog(@"%@", NSStringFromCGPoint(point));
  CGRect rect = CGRectMake(point.x - 1, point.y - 1, 2, 2);
  CGContextFillRect(ctx, rect);
}

@end
