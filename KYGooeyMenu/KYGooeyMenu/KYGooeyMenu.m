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
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,strong)UIDynamicAnimator *animator;

@end


@implementation KYGooeyMenu{
    NSMutableDictionary *PointsDic;
    NSMutableArray *Menus;      // 存放menus
    NSMutableArray *MenuLayers; // 存放menus对应的layer
    CGRect menuFrame;
    NSInteger menuCount;
    UIColor *menuColor;
    CGFloat R;
    CGFloat r;
    CGFloat distance;
    BOOL isOpened;
    BOOL dLargerThanDis;
    CAShapeLayer *verticalLineLayer;
}



-(id)initWithOrigin:(CGPoint)origin andDiameter:(CGFloat)diameter andMenuCount:(NSInteger)count andDelegate:(UIViewController *)controller themeColor:(UIColor *)themeColor{
    menuFrame = CGRectMake(origin.x, origin.y, diameter, diameter);
    self = [super initWithFrame:menuFrame];

    
    if (self) {
        PointsDic = [NSMutableDictionary dictionary];
        Menus = [NSMutableArray arrayWithCapacity:count];
        MenuLayers = [NSMutableArray arrayWithCapacity:count];
        menuCount = count;
        menuColor = themeColor;
        isOpened = NO;
        self.containerView = controller.view;
        [self.containerView addSubview:self];
        self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.mainView];

    }
    
    return self;
}



-(void)setUp{
    
    self.mainView = [[UIView alloc]initWithFrame:menuFrame];
    self.mainView.backgroundColor = menuColor;
    self.mainView.layer.cornerRadius = self.mainView.bounds.size.width / 2;
    self.mainView.layer.masksToBounds = YES;
    [self.containerView addSubview:self.mainView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToOpenUp)];
    [self.mainView addGestureRecognizer:tapGes];
    
    
    //-----------计算目标点的位置----------
    R = self.mainView.bounds.size.width / 2;
    r = self.mainView.bounds.size.width / 4;
    //子视图离开主视图的距离 [distance]
    distance = R + r + 20;
    //平分之后的角度,弧度制，因为sinf、cosf需要弧度制
    CGFloat degree = (180/(menuCount+1))*(M_PI/180);
    
    
    //参考点的坐标
    CGPoint originPoint = self.mainView.center;
    for (NSInteger i = 0; i < menuCount; i++) {
        CGFloat cosDegree = cosf(degree * (i+1));
        CGFloat sinDegree = sinf(degree * (i+1));

        CGPoint center = CGPointMake(originPoint.x + distance*cosDegree, originPoint.y - distance*sinDegree);
        NSLog(@"centers:%@",NSStringFromCGPoint(center));
        [PointsDic setObject:[NSValue valueWithCGPoint:center] forKey:[NSString stringWithFormat:@"center%ld",(long)i+1]];
        
        //创建每个menu
        UIView *item = [[UIView alloc]initWithFrame:CGRectZero];
        item.backgroundColor = menuColor;
        item.tag = i+1;
        item.center = self.mainView.center;
        item.bounds = CGRectMake(0, 0, r *2, r*2);
        item.layer.cornerRadius = item.bounds.size.width / 2;
        [self.containerView addSubview:item];
        [self.containerView sendSubviewToBack:item];
        [Menus addObject:item];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = menuColor.CGColor;
        [self.containerView.layer insertSublayer:shapeLayer atIndex:0];
        [MenuLayers addObject:shapeLayer];
    
    }

}

- (CGPathRef) getRightLinePathWithAmount:(CGFloat)amount {
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    CGPoint pointA = CGPointMake(self.mainView.center.x - self.mainView.bounds.size.width/2, self.mainView.center.y) ;
    CGPoint pointB = CGPointMake(self.mainView.center.x, self.mainView.center.y - self.mainView.bounds.size.height/2);
    CGPoint pointC = CGPointMake(self.mainView.center.x + self.mainView.bounds.size.width/2, self.mainView.center.y);
    CGPoint pointD = CGPointMake(self.mainView.center.x, self.mainView.center.y + self.mainView.bounds.size.height/2);
    CGPoint pointO = CGPointMake(self.mainView.frame.origin.x - amount * cosf(45 *(M_PI/180)), self.mainView.frame.origin.y - amount * cosf(45 *(M_PI/180)));
    CGPoint pointP = CGPointMake(self.mainView.frame.origin.x + self.mainView.bounds.size.width + amount * cosf(45 *(M_PI/180)),self.mainView.frame.origin.y - amount * cosf(45 *(M_PI/180)));

    [verticalLine moveToPoint:pointA];
    [verticalLine addQuadCurveToPoint:pointB controlPoint:pointO];
    [verticalLine addQuadCurveToPoint:pointC controlPoint:pointP];
    [verticalLine addArcWithCenter:self.mainView.center radius:R startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    
    return [verticalLine CGPath];
}



-(void)tapToOpenUp{

    if (verticalLineLayer == nil) {
        verticalLineLayer = [CAShapeLayer layer];
        verticalLineLayer.fillColor = [[UIColor redColor] CGColor];
        [self.containerView.layer addSublayer:verticalLineLayer];
    }
    
    CGFloat positionX = 40.0f;
    NSArray *values1_0 = @[
                           (id) [self getRightLinePathWithAmount:(positionX * 0.6)],
                           (id) [self getRightLinePathWithAmount:-(positionX * 0.4)],
                           (id) [self getRightLinePathWithAmount:(positionX * 0.25)],
                           (id) [self getRightLinePathWithAmount:-(positionX * 0.15)],
                           (id) [self getRightLinePathWithAmount:(positionX * 0.05)],
                           (id) [self getRightLinePathWithAmount:0.0]
                           ];
    
    NSArray *values0_1 = @[
                           (id) [self getRightLinePathWithAmount:0.0],
                           (id) [self getRightLinePathWithAmount:(positionX * 0.05)],
                           (id) [self getRightLinePathWithAmount:-(positionX * 0.25)],
                           (id) [self getRightLinePathWithAmount:(positionX * 0.6)],
                           (id) [self getRightLinePathWithAmount:-(positionX * 0.25)],
                           (id) [self getRightLinePathWithAmount:(positionX * 0.05)],
                           (id) [self getRightLinePathWithAmount:0.0]
                           ];

    if (isOpened == NO) {
        CAKeyframeAnimation *morph = [CAKeyframeAnimation animationWithKeyPath:@"path"];
        morph.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        morph.values = values0_1;
        morph.duration = 0.8f;
        morph.removedOnCompletion = NO;
        morph.fillMode = kCAFillModeForwards;
        morph.delegate = self;
        [verticalLineLayer addAnimation:morph forKey:@"bounce_0_1"];
        
        for (UIView *item in Menus) {
            
        
            [UIView animateWithDuration:0.5f delay:0.05*item.tag usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                NSValue *pointValue = [PointsDic objectForKey:[NSString stringWithFormat:@"center%ld",item.tag]];
                CGPoint terminalPoint = [pointValue CGPointValue];
                item.center = terminalPoint;
            } completion:nil];
            
//            UISnapBehavior *snap1 = [[UISnapBehavior alloc]initWithItem:item snapToPoint:terminalPoint];
//            snap1.action = ^(){
//                [self updateLayerPath];
//            };
//            
//            [self.animator addBehavior:snap1];
            
        }
        isOpened = YES;
    }else{
        CAKeyframeAnimation *morph = [CAKeyframeAnimation animationWithKeyPath:@"path"];
        morph.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        morph.values = values1_0;
        morph.duration = 0.8f;
        morph.removedOnCompletion = NO;
        morph.fillMode = kCAFillModeForwards;
        morph.delegate = self;
        [verticalLineLayer addAnimation:morph forKey:@"bounce_1_0"];
        
        for (UIView *item in Menus) {
            
            [UIView animateWithDuration:0.5f delay:0.05*item.tag usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                CGPoint terminalPoint = self.mainView.center;
                item.center = terminalPoint;
            } completion:nil];
//            UISnapBehavior *snap2 = [[UISnapBehavior alloc]initWithItem:item snapToPoint:terminalPoint];
//            snap2.action = ^(){
//                [self updateLayerPath];
//            };
//            [self.animator addBehavior:snap2];
            
            
        }
        isOpened = NO;
        
    }
    
}


-(void)updateLayerPath{
    CGPoint originPoint = self.mainView.center;
    CGFloat degree = (180/(menuCount+1))*(M_PI/180);
    
    for (NSInteger i = 0; i < menuCount; i++) {
        CGFloat cosDegree = cosf(degree * (i+1));
        CGFloat sinDegree = sinf(degree * (i+1));

        
        UIView  *menu_  = (UIView*)Menus[i];
        CALayer *layer_ = [menu_.layer presentationLayer];
        CGPoint movingCenter = CGPointMake(layer_.frame.origin.x + layer_.frame.size.width/2, layer_.frame.origin.y + layer_.frame.size.height/2);
        CGFloat d = sqrtf((movingCenter.x-originPoint.x)*(movingCenter.x-originPoint.x) + (movingCenter.y-originPoint.y)*(movingCenter.y-originPoint.y));
        
        
        //更新layer的path
        CGPoint pointA = CGPointMake(originPoint.x - R*sinDegree , originPoint.y - R*cosDegree);
        CGPoint pointB = CGPointMake(originPoint.x + R*sinDegree , originPoint.y + R*cosDegree);
        CGPoint pointC = CGPointMake(originPoint.x + r*sinDegree + d*cosDegree, originPoint.y - d*sinDegree + r*cosDegree);
        CGPoint pointD = CGPointMake(originPoint.x + d*cosDegree - r*sinDegree,originPoint.y - d*sinDegree - r*cosDegree);
        CGPoint itemCenter = CGPointMake((pointC.x+pointD.x)/2, (pointC.y+pointD.y)/2);
        
        CGPoint controlpoint = CGPointMake((itemCenter.x + originPoint.x)/2, (itemCenter.y  + originPoint.y)/2);
        CGPoint controlPointRight = CGPointMake(controlpoint.x + (r/2)*sinDegree, controlpoint.y + (r/2)*cosDegree);
        CGPoint controlPointLeft = CGPointMake(controlpoint.x - (r/2)*sinDegree, controlpoint.y - (r/2)*cosDegree);
        
        CGPoint controlPoint1 = CGPointMake(itemCenter.x+r*cosDegree, itemCenter.y-r*sinDegree);

        
//        //-----tuning------
//        UIView *helperViewA = [[UIView alloc]initWithFrame:CGRectZero];
//        helperViewA.backgroundColor = [UIColor blueColor];
//        helperViewA.center = pointA;
//        helperViewA.bounds = CGRectMake(0, 0, 10, 10);
//        [self.containerView addSubview:helperViewA];
//        
//        UIView *helperViewB = [[UIView alloc]initWithFrame:CGRectZero];
//        helperViewB.backgroundColor = [UIColor yellowColor];
//        helperViewB.center = pointB;
//        helperViewB.bounds = CGRectMake(0, 0, 10, 10);
//        [self.containerView addSubview:helperViewB];
//        
//        UIView *helperViewC = [[UIView alloc]initWithFrame:CGRectZero];
//        helperViewC.backgroundColor = [UIColor purpleColor];
//        helperViewC.center = pointC;
//        helperViewC.bounds = CGRectMake(0, 0, 10, 10);
//        [self.containerView addSubview:helperViewC];
//        
//        UIView *helperViewD = [[UIView alloc]initWithFrame:CGRectZero];
//        helperViewD.backgroundColor = [UIColor orangeColor];
//        helperViewD.center = pointD;
//        helperViewD.bounds = CGRectMake(0, 0, 10, 10);
//        [self.containerView addSubview:helperViewD];
//        
//        UIView *helperViewE = [[UIView alloc]initWithFrame:CGRectZero];
//        helperViewE.backgroundColor = [UIColor greenColor];
//        helperViewE.center = controlPoint;
//        helperViewE.bounds = CGRectMake(0, 0, 10, 10);
//        [self.containerView addSubview:helperViewE];
//        //-------
        
        UIBezierPath *layerPath = [UIBezierPath bezierPath];
        [layerPath moveToPoint:pointA];
        [layerPath addLineToPoint:pointB];
//        [layerPath addLineToPoint:pointC];
        [layerPath addQuadCurveToPoint:pointC controlPoint:controlPointRight];
        [layerPath addQuadCurveToPoint:pointD controlPoint:controlPoint1];
//        [layerPath addLineToPoint:pointD];
        [layerPath addQuadCurveToPoint:pointA controlPoint:controlPointLeft];
        
        CAShapeLayer *menuLayer_ = (CAShapeLayer *)MenuLayers[i];
        menuLayer_.path = layerPath.CGPath;
        
        
        if (d > R+r-5 ) {
            menuLayer_.hidden = YES;
//            dLargerThanDis = YES;
        }else{
            menuLayer_.hidden = NO;
//            dLargerThanDis = NO;
        }
    }
    
    
    
}




@end
