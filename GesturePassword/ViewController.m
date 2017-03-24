//
//  ViewController.m
//  GesturePassword
//
//  Created by 吴凡 on 16/9/12.
//  Copyright © 2016年 吴凡. All rights reserved.
//

#import "ViewController.h"
#import "GesPasswordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GesPasswordView *view = [[GesPasswordView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
