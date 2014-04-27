//
//  Animator.h
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CANavigationAnimation;
@protocol CANavigationAnimationDelegate <NSObject>

-(void)navigationAnimationDidFinish:(CANavigationAnimation *)animator;

@end

@interface CANavigationAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) UIViewAnimationOptions curve;
@property (nonatomic, weak) id<CANavigationAnimationDelegate>delegate;

@end
