//
//  KYSpringLayerAnimation.m
//  KYAnimatedPageControl-Demo
//
//  Created by Kitten Yang on 6/10/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYSpringLayerAnimation.h"

@implementation KYSpringLayerAnimation

+(instancetype)sharedAnimManager{
    
    static KYSpringLayerAnimation *animManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        animManager = [[KYSpringLayerAnimation alloc]init];
    });
    return animManager;
}


#pragma mark -- Main Class Methods

-(CAKeyframeAnimation *)createBasicAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue{
    
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self basicAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}

-(CAKeyframeAnimation *)createSpringAnima:(NSString *)keypath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue toValue:(id)toValue{
    
    CGFloat dampingFactor  = 10.0;
    CGFloat velocityFactor = 10.0;
    NSMutableArray *values = [self springAnimationValues:fromValue toValue:toValue usingSpringWithDamping:damping * dampingFactor initialSpringVelocity:velocity * velocityFactor duration:duration];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = values;
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}


-(CAKeyframeAnimation *)createCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self curveAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}


-(CAKeyframeAnimation *)createHalfCurveAnima:(NSString *)keypath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self halfCurveAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
    
}


#pragma mark -- Helper Methods
-(NSMutableArray *) basicAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration{
    
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame<numOfFrames; frame++) {
        
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * x;
        values[frame] = @(value);
    }
    return values;
}


-(NSMutableArray *) halfCurveAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration{
    
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame<numOfFrames; frame++) {
        
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * (-x *(x-2));
        values[frame] = @(value);
    }
    return values;
}


-(NSMutableArray *) curveAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration{

    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame<numOfFrames; frame++) {
        
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * (-4* x *(x-1));
        values[frame] = @(value);
    }
    return values;
}


-(NSMutableArray *) springAnimationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration{
    
    
    //60个关键帧
    NSInteger numOfFrames  = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    //差值
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    
    for (NSInteger frame = 0; frame<numOfFrames; frame++) {
        
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [toValue floatValue] - diff * (pow(M_E, -damping * x) * cos(velocity * x)); // y = 1-e^{-5x} * cos(30x)
        
        values[frame] = @(value);
    }

    return values;
    
}





@end
