//
//  KYGooeyMenu.h
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYGooeyMenu : UIView

@property(nonatomic,assign)NSInteger MenuCount;

-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andDelegate:(UIViewController *)controller themeColor:(UIColor *)themeColor;


@end
