//
//  CANavigationAnimationSlide.m
//  CASloppyPopViewController
//
//  Created by Christoph Albert on 4/27/14.
//  Copyright (c) 2014 Christoph Albert. All rights reserved.
//

#import "CANavigationAnimationSlide.h"

@implementation CANavigationAnimationSlide

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.36;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.operation == UINavigationControllerOperationNone) {
        return;
    }

    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGFloat fadeAlpha = 0.6;
    CGFloat slideOffset = 160;

    if (self.operation == UINavigationControllerOperationPop) {
        [[transitionContext containerView] insertSubview:toViewController.view atIndex:0];

        CGRect toStartFrame = toViewController.view.frame;
        toStartFrame.origin.x = toStartFrame.origin.x-slideOffset;
        toViewController.view.frame = toStartFrame;

        CGRect fromDestFrame = fromViewController.view.frame;
        fromDestFrame.origin.x = fromViewController.view.frame.size.width;

        UIView *fadeView = [[UIView alloc] initWithFrame:[transitionContext containerView].frame];
        fadeView.alpha = fadeAlpha;
        fadeView.backgroundColor = [UIColor blackColor];

        [[transitionContext containerView] insertSubview:fadeView aboveSubview:toViewController.view];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:self.curve animations:^{
            toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
            fromViewController.view.frame = fromDestFrame;
            fadeView.alpha = 0;
        } completion:^(BOOL finished) {
            [fadeView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([self.delegate respondsToSelector:@selector(navigationAnimationDidFinish:)]) {
                [self.delegate navigationAnimationDidFinish:self];
            }
        }];
    } else {
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
        CGRect toStartFrame = toViewController.view.frame;
        toStartFrame.origin.x = toViewController.view.frame.size.width;
        toViewController.view.frame = toStartFrame;

        UIView *fadeView = [[UIView alloc] initWithFrame:[transitionContext containerView].frame];
        fadeView.alpha = 0;
        fadeView.backgroundColor = [UIColor blackColor];

        [[transitionContext containerView] insertSubview:fadeView aboveSubview:fromViewController.view];

        CGRect fromDestFrame = fromViewController.view.frame;
        fromDestFrame.origin.x = fromDestFrame.origin.x-slideOffset;

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:self.curve animations:^{
            toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
            fromViewController.view.frame = fromDestFrame;
            fadeView.alpha = fadeAlpha;
        } completion:^(BOOL finished) {
            [fadeView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([self.delegate respondsToSelector:@selector(navigationAnimationDidFinish:)]) {
                [self.delegate navigationAnimationDidFinish:self];
            }
        }];
    }
}

@end
