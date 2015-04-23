//
//  KYGooeyMenu.m
//  KYGooeyMenu
//
//  Created by Kitten Yang on 4/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYGooeyMenu.h"


@interface KYGooeyMenu()

@property(nonatomic,strong)UIView *mainView;
//@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,assign)NSInteger subViewcounts;

@end

@implementation KYGooeyMenu{
    NSMutableDictionary *PointsDic;
    UIView *containerView;
    CGRect menuFrame;
    NSInteger menuCount;
    UIColor *menuColor;
}



-(id)initWithOrigin:(CGPoint)origin andRadius:(CGFloat)radius andMenuCount:(NSInteger)count andDelegate:(UIViewController *)controller themeColor:(UIColor *)themeColor{
    menuFrame = CGRectMake(origin.x, origin.y, radius, radius);
    self = [super initWithFrame:menuFrame];

    
    if (self) {
        PointsDic = [NSMutableDictionary dictionary];
        containerView = controller.view;
        menuCount = count;
        menuColor = themeColor;

    }
    
    return self;
}



-(void)setUp{
    
    self.subViewcounts = menuCount;
    self.mainView = [[UIView alloc]initWithFrame:menuFrame];
    self.mainView.backgroundColor = menuColor;
    self.mainView.layer.cornerRadius = self.mainView.bounds.size.width / 2;
    self.mainView.layer.masksToBounds = YES;
    [containerView addSubview:self.mainView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToOpenUp)];
    [self.mainView addGestureRecognizer:tapGes];
    
    for (NSInteger i = 0; i < menuCount; i++) {
        UIView *item = [[UIView alloc]initWithFrame:CGRectZero];
        item.backgroundColor = menuColor;
        item.center = self.mainView.center;
        item.tag = i+1;
        item.bounds = CGRectMake(0, 0, self.mainView.bounds.size.width *2/3, self.mainView.bounds.size.height *2/3);
        item.layer.cornerRadius = item.bounds.size.width / 2;
        [containerView addSubview:item];
        [containerView sendSubviewToBack:item];
    }
    
    //-----------计算目标点的位置----------
    //子视图离开主视图的距离
    NSInteger distance = self.mainView.bounds.size.width/2 + self.mainView.bounds.size.width *2/3 + 50;
    //平分之后的角度
    CGFloat degree = 180/(menuCount+1);
    
    //参考点的坐标
    CGPoint originPoint = self.mainView.center;
    for (NSInteger i = 0; i < menuCount; i++) {
        CGFloat cosDegree = cosf(degree * (i+1));
        CGFloat sinDegree = sinf(degree * (i+1));

        CGPoint center = CGPointMake(originPoint.x+distance*cosDegree, originPoint.y + distance*sinDegree);
        [PointsDic setObject:[NSValue valueWithCGPoint:center] forKey:[NSString stringWithFormat:@"center%ld",(long)i+1]];
        
    }
    
    
    
}


-(void)tapToOpenUp{

    NSLog(@"sss");
//    for (UIView *item in self.mainView.subviews) {
//        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            NSValue *pointValue = [PointsDic objectForKey:[NSString stringWithFormat:@"center%ld",item.tag]];
//            CGPoint terminalPoint = [pointValue CGPointValue];
//            item.center = terminalPoint;
//        } completion:nil];
//    }
}















@end
