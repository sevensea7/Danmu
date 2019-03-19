//
//  BulletManager.h
//  DanmuDemo
//
//  Created by Hayden on 2017/12/14.
//  Copyright © 2017年 惠装科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;
@interface BulletManager : NSObject
@property (nonatomic, copy) void (^generateViewBlock)(BulletView *view);


// 弹幕开始执行
- (void)start;

// 弹幕停止执行
- (void)stop;

@end
