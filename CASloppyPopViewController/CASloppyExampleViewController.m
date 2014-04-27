//
//  CAViewController.m
//  CASloppyPopViewController
//
//  Created by Christoph Albert on 4/27/14.
//  Copyright (c) 2014 Christoph Albert. All rights reserved.
//

#import "CASloppyExampleViewController.h"

@interface CASloppyExampleViewController ()

@property (nonatomic, strong) UIButton *pushButton;

@end

@implementation CASloppyExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.view.backgroundColor = color;

    [self.view addSubview:self.pushButton];
}

-(UIButton *)pushButton {
    if (_pushButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Push" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pushButton = button;
    }
    return _pushButton;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat width = 200;
    CGFloat height = 44;
    self.pushButton.frame = CGRectMake((self.view.frame.size.width-width)/2, (self.view.frame.size.height-height)/2, width, height);
}

-(void)pushButtonTapped:(UIButton *)button {
    CASloppyExampleViewController *example = [[CASloppyExampleViewController alloc] init];
    [self.navigationController pushViewController:example animated:YES];
}

@end
