//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "CANavigationAnimator.h"

@implementation CANavigationAnimator

-(id)init {
    self = [super init];
    if (self) {
        self.type = CANavigationAnimatorTypePop;
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
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];

    CGFloat offset;
    if (self.type == CANavigationAnimatorTypePush) {
        offset = fromViewController.view.frame.size.width;
    } else {
        offset = -toViewController.view.frame.size.width;
    }

    CGRect toStartFrame = toViewController.view.frame;
    toStartFrame.origin.x = offset;
    toViewController.view.frame = toStartFrame;

    CGRect fromDestFrame = fromViewController.view.frame;
    fromDestFrame.origin.x = -offset;
    fromViewController.view.frame = [transitionContext initialFrameForViewController:fromViewController];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:self.curve animations:^{
        fromViewController.view.frame = fromDestFrame;
        toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([self.delegate respondsToSelector:@selector(navigationAnimatorDidFinish:)]) {
            [self.delegate navigationAnimatorDidFinish:self];
        }
    }];
}

@end
