//
//  NavigationControllerDelegate.m
//  NavigationTransitionController
//
//  Created by Chris Eidhof on 09.10.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "CASloppyNavigationControllerDelegate.h"
#import "CANavigationAnimationSlide.h"

@interface CASloppyNavigationControllerDelegate () <UIGestureRecognizerDelegate, CANavigationAnimationDelegate> {
    BOOL _transitioning;
}

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation CASloppyNavigationControllerDelegate

-(id)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        self.navigationController = navigationController;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        navigationController.delegate = self;
        [self activatePan];
    }
    return self;
}

-(void)awakeFromNib {
    [self activatePan];
}

-(void)activatePan {
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.navigationController.view addGestureRecognizer:panRecognizer];
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.navigationController.view;
    CGFloat progress = [recognizer translationInView:view].x / (view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));

    if (recognizer.state == UIGestureRecognizerStateBegan && !_transitioning) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        _transitioning = YES;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactionController updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0 && progress > 0.25) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    CANavigationAnimationSlide *animation = [CANavigationAnimationSlide new];
    animation.delegate = self;
    animation.operation = operation;
    if (self.interactionController != nil) {
        animation.curve = UIViewAnimationOptionCurveLinear;
    }
    return animation;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        return NO;
    }
    return YES;
}

-(void)navigationAnimationDidFinish:(CANavigationAnimation *)animator {
    _transitioning = NO;
}

@end
