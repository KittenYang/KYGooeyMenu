//
//  KYGooeyMenu.h
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYGooeyMenu : UIView

//@property(nonatomic,strong)UIColor *themeColor;


-(id)initWithOrigin:(CGPoint)origin andRadius:(CGFloat)radius andMenuCount:(NSInteger)count andDelegate:(UIViewController *)controller themeColor:(UIColor *)themeColor;
-(void)setUp;

@end
