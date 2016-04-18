//
//  Menu.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 15/8/23.
//  Copyright (c) 2015年 Kitten Yang. All rights reserved.
//

#import "KYSpringLayerAnimation.h"
#import "Menu.h"

@interface Menu ()
@property(nonatomic, strong) NSMutableArray *animationQueue;
@end

@implementation Menu
- (id)initWithFrame:(CGRect)frame {
  CGRect real_frame = CGRectInset(frame, -30, -30);
  self = [super initWithFrame:real_frame];
  if (self) {
    _animationQueue = [NSMutableArray arrayWithCapacity:3];
  }
  return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  _menuLayer = [MenuLayer layer];
  _menuLayer.frame = self.bounds;
  _menuLayer.contentsScale = [UIScreen mainScreen].scale;
  [self.layer addSublayer:_menuLayer];
  [_menuLayer setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  switch (touch.tapCount) {
  case 1:

    [self openAnimation];

    break;

  default:

    break;
  }
}

- (void)openAnimation {
  CAKeyframeAnimation *openAnimation_1 =
      [[KYSpringLayerAnimation sharedAnimManager]
          createBasicAnima:@"xAxisPercent"
                  duration:0.3
                 fromValue:@(0)
                   toValue:@(1)];
  openAnimation_1.delegate = self;
  CAKeyframeAnimation *openAnimation_2 =
      [[KYSpringLayerAnimation sharedAnimManager]
          createBasicAnima:@"xAxisPercent"
                  duration:0.3
                 fromValue:@(0)
                   toValue:@(1)];
  openAnimation_2.delegate = self;
  CAKeyframeAnimation *openAnimation_3 =
      [[KYSpringLayerAnimation sharedAnimManager]
               createSpringAnima:@"xAxisPercent"
                        duration:1.0
          usingSpringWithDamping:0.5
           initialSpringVelocity:3.0
                       fromValue:@(0)
                         toValue:@(1)];
  openAnimation_3.delegate = self;

  [_animationQueue addObject:openAnimation_1];
  [_animationQueue addObject:openAnimation_2];
  [_animationQueue addObject:openAnimation_3];

  [self.menuLayer addAnimation:openAnimation_1 forKey:@"openAnimation_1"];
  self.userInteractionEnabled = NO;
  _menuLayer.animState = STATE1;
}

- (void)nextAnimation {
  if (_animationQueue.count == 0) {
    return;
  }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  if (flag) {
    if ([anim isEqual:[self.menuLayer animationForKey:@"openAnimation_1"]]) {
      [self.menuLayer removeAllAnimations];
      [self.menuLayer addAnimation:[_animationQueue objectAtIndex:1]
                            forKey:@"openAnimation_2"];
      _menuLayer.animState = STATE2;
    } else if ([anim isEqual:[self.menuLayer
                                 animationForKey:@"openAnimation_2"]]) {
      [self.menuLayer removeAllAnimations];
      [self.menuLayer addAnimation:[_animationQueue objectAtIndex:2]
                            forKey:@"openAnimation_3"];
      _menuLayer.animState = STATE3;
    } else if ([anim isEqual:[self.menuLayer
                                 animationForKey:@"openAnimation_3"]]) {
      self.menuLayer.xAxisPercent = 1.0;
      [self.menuLayer removeAllAnimations];
      self.userInteractionEnabled = YES;
    }
  }
}

@end
