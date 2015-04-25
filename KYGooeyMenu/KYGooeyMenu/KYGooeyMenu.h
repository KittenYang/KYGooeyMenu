//
//  KYGooeyMenu.h
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol menuDidSelectedDelegate <NSObject>

-(void)menuDidSelected:(NSInteger)index;

@end

@interface KYGooeyMenu : UIView

//******菜单的个数*********
@property(nonatomic,assign)NSInteger MenuCount;

//******子菜单的半径*********
@property(nonatomic,assign)CGFloat radius;

//******子菜单离开父菜单的距离*********
//这里的距离是指 除了"R+r" 额外的高度，也就是中间空白的距离，如果distance设为0，你将看到它们相切。
@property(nonatomic,assign)CGFloat extraDistance;


-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andDelegate:(UIViewController *)controller themeColor:(UIColor *)themeColor;

@property(nonatomic,weak)id<menuDidSelectedDelegate> menuDelegate;
@end
