//
//  ViewController.m
//  CoreGraphicsDemo
//
//  Created by HK on 18/3/21.
//  Copyright © 2018年 HK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CGView *cgView;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)dealloc{
    [_displayLink invalidate];
    _displayLink = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat W = self.view.bounds.size.width, H = self.view.bounds.size.height;

    CGView *view = [[CGView alloc] initWithFrame:CGRectMake(0, 64, W, H-64) type:self.type];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.cgView = view;
    
    if (self.type>3) {
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, H-60, W, 60)];
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
    }
    
    if (self.type==CGViewTypePee) {
        
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, H-120, W, 60)];
        [slider addTarget:self action:@selector(speedChanged:) forControlEvents:UIControlEventValueChanged];
        slider.thumbTintColor = [UIColor greenColor];
        [self.view addSubview:slider];

        UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
        play.frame = CGRectMake(20, H-160, 60, 30);
        [play setTitle:@"play" forState:UIControlStateNormal];
        [play addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
        play.backgroundColor = [UIColor blueColor];
        [self.view addSubview:play];
        
        UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
        stop.frame = CGRectMake(W-60-20, H-160, 60, 30);
        [stop setTitle:@"stop" forState:UIControlStateNormal];
        [stop addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
        stop.backgroundColor = [UIColor blueColor];
        [self.view addSubview:stop];
        self.cgView.xSpeed = 1;
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        self.displayLink.paused = YES;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
}

- (void)sliderValueChanged:(UISlider *)slider{
    self.cgView.progress = slider.value;
}

- (void)speedChanged:(UISlider *)slider{
    self.cgView.xSpeed = 1.0+10*slider.value;
}

-(void)update{
    if (self.cgView.progress>1) {
        self.cgView.progress = 0;
    }
    self.cgView.progress+=0.02;
}


- (void)startAnimation{
    self.displayLink.paused = NO;
}

- (void)stopAnimation{
    self.displayLink.paused = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
