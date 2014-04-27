//
//  CANavigationAnimationSlide.m
//  CASloppyPopViewController
//
//  Created by Christoph Albert on 4/27/14.
//  Copyright (c) 2014 Christoph Albert. All rights reserved.
//

#import "CANavigationAnimationSlide.h"

@implementation CANavigationAnimationSlide

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.operation == UINavigationControllerOperationNone) {
        return;
    }

    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];

    CGFloat offset;
    if (self.operation == UINavigationControllerOperationPop) {
        offset = -toViewController.view.frame.size.width;
    } else {
        offset = fromViewController.view.frame.size.width;
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
        if ([self.delegate respondsToSelector:@selector(navigationAnimationDidFinish:)]) {
            [self.delegate navigationAnimationDidFinish:self];
        }
    }];
}

@end
