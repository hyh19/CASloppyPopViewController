//
//  NavigationControllerDelegate.h
//  NavigationTransitionController
//
//  Created by Chris Eidhof on 09.10.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CASloppyNavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

@property (nonatomic, strong) Class animationClass;

-(id)initWithNavigationController:(UINavigationController *)navigationController;

@end
