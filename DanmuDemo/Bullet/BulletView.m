//
//  BulletView.m
//  DanmuDemo
//
//  Created by Hayden on 2017/12/14.
//  Copyright © 2017年 惠装科技. All rights reserved.
//

#import "BulletView.h"

#define Padding 10
#define PhotoHeight 30

@interface BulletView ()
@property (nonatomic, strong) UILabel *lbComment;
@property (nonatomic, strong) UIImageView *photoIV;

@end

@implementation BulletView

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blueColor];
        self.layer.cornerRadius = 15;
        
        // 计算弹幕的实际宽度
        NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + Padding * 2 + PhotoHeight, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding + PhotoHeight, 0, width, 30);
        
        self.photoIV.frame = CGRectMake(-Padding, -Padding, PhotoHeight + Padding, PhotoHeight + Padding);
        self.photoIV.layer.cornerRadius = (PhotoHeight + Padding)/2;
        self.photoIV.layer.borderColor = [UIColor whiteColor].CGColor;
        self.photoIV.layer.borderWidth = 1;
        self.photoIV.image = [UIImage imageNamed:@"pika"];
        self.photoIV.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// 开启动画
- (void)startAnimation {

    // 根据弹幕长度执行动画效果
    // 根据v=s/t, 时间相同情况下，距离越长，速度越快
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    
    // 弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    // t = s/v
    CGFloat speed = wholeWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    // 延迟方法
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];

    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x = frame.origin.x - wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
}

- (void)enterScreen {
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}

// 结束动画
- (void)stopAnimation {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (UILabel *)lbComment {
    if (!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}

- (UIImageView *)photoIV {
    if (!_photoIV) {
        _photoIV = [[UIImageView alloc] init];
        _photoIV.clipsToBounds = YES;
        _photoIV.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_photoIV];
    }
    return _photoIV;
}

@end
