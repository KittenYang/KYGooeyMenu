//
//  KYGooeyMenu.h
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol menuDidSelectedDelegate <NSObject>

-(void)menuDidSelected:(int)index;

@end

@interface KYGooeyMenu : UIView

//******菜单的个数*********
//The number of the menu
@property(nonatomic,assign)int MenuCount;

//******子菜单的半径*********
//the radius of the menu
@property(nonatomic,assign)CGFloat radius;

//******子菜单离开父菜单的距离*********
//这里的距离是指 除了"R+r" 额外的高度，也就是中间空白的距离，如果distance设为0，你将看到它们相切。
//This property means the extra distance between super-menu anf sub-menu(if you set extraDistance=0 ,you will see the sub-menu is tangent to the super-menu)
@property(nonatomic,assign)CGFloat extraDistance;

//外部使用中，如需隐藏或者动画，请访问mainView 这个属性
//if you want to hidden this gooey menu or you wanna transform like translation,you must use this property
@property(nonatomic,strong)UIView *mainView;


//添加菜单图标
@property(nonatomic,strong)NSMutableArray *menuImagesArray;


-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andDelegate:(UIViewController *)controller themeColor:(UIColor *)themeColor;

@property(nonatomic,weak)id<menuDidSelectedDelegate> menuDelegate;
@end
