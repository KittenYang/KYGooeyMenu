//
//  MenuLayer.h
//  KYGooeyMenu
//
//  Created by Kitten Yang on 15/8/23.
//  Copyright (c) 2015年 Kitten Yang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  STATE1,
  STATE2,
  STATE3,
} STATE;

@interface MenuLayer : CALayer

@property(nonatomic, assign) BOOL showDebug;
@property(nonatomic, assign) STATE animState;
@property(nonatomic, assign) CGFloat xAxisPercent;

@end
