//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "CANavigationAnimation.h"

@implementation CANavigationAnimation

-(id)init {
    self = [super init];
    if (self) {
        self.operation = UINavigationControllerOperationPop;
        self.curve = UIViewAnimationOptionCurveEaseInOut;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return;
}

@end
