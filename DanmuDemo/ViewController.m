//
//  ViewController.m
//  DanmuDemo
//
//  Created by Hayden on 2017/12/14.
//  Copyright © 2017年 惠装科技. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"

@interface ViewController ()
@property (nonatomic, strong) BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.manager = [[BulletManager alloc] init];
    __weak typeof (self) weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView *view) {
        [weakSelf addBulletView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"stop" forState:UIControlStateNormal];
    btn.frame = CGRectMake(250, 100, 100, 40);
    [btn addTarget:self action:@selector(clickStopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)clickBtn {
    [self.manager start];
}

- (void)clickStopBtn {
    [self.manager stop];
}

- (void)addBulletView:(BulletView *)view {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300 + view.trajectory * 50, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
