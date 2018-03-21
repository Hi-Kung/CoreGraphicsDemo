//
//  ViewController.m
//  CoreGraphicsDemo
//
//  Created by HK on 18/3/21.
//  Copyright © 2018年 HK. All rights reserved.
//

#import "ViewController.h"
#import "CGView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGView *view = [[CGView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
