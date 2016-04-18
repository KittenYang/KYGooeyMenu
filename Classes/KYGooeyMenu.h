//
//  KYGooeyMenu.h
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol menuDidSelectedDelegate <NSObject>

- (void)menuDidSelected:(int)index;

@end

@interface KYGooeyMenu : UIView

/**
 *  The number of the items
 */
@property(nonatomic, assign) int MenuCount;

/**
 *  the radius of the item
 */
@property(nonatomic, assign) CGFloat radius;

/**
 *  这里的距离是指 除了"R+r"
 * 额外的高度，也就是中间空白的距离，如果distance设为0，你将看到它们相切
 *  This property means the extra distance between menu and items(if you set
 * extraDistance=0 ,you will see the items are tangent to the menu)
 */
@property(nonatomic, assign) CGFloat extraDistance;

/**
 *  if you want to hidden this gooey menu or you wanna transform such as
 * translation,you must use this property
 */
@property(nonatomic, strong) UIView *mainView;

/**
 *  add item images
 */
@property(nonatomic, strong) NSMutableArray *menuImagesArray;

/**
 *  Initialize
 *
 *  @param origin     the origin of menu
 *  @param diameter   diameter
 *  @param superView  superView
 *  @param themeColor the theme color of menu and item
 *
 *  @return self
 */
- (id)initWithOrigin:(CGPoint)origin
         andDiameter:(CGFloat)diameter
        andSuperView:(UIView *)superView
          themeColor:(UIColor *)themeColor;

/**
 *  The delegate of KYGooeyMenu
 */
@property(nonatomic, weak) id<menuDidSelectedDelegate> menuDelegate;

@end
