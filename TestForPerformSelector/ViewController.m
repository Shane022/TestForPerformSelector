//
//  ViewController.m
//  TestForPerformSelector
//
//  Created by new on 16/10/28.
//  Copyright © 2016年 new. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIButton *_btnSendCaptcha;
    NSInteger _count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayoutAndInitData];
}

- (void)setupLayoutAndInitData {
    _count = 10;
    CGFloat btnWidth = 120;
    CGFloat btnHeight = 40;
    _btnSendCaptcha = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSendCaptcha setFrame:CGRectMake((self.view.frame.size.width-btnWidth)/2, (self.view.frame.size.height-btnHeight)/2, btnWidth, btnHeight)];
    [_btnSendCaptcha setBackgroundColor:[UIColor orangeColor]];
    [_btnSendCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_btnSendCaptcha setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSendCaptcha addTarget:self action:@selector(onHitBtnGetCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSendCaptcha.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_btnSendCaptcha];
}

- (void)startCountDown {
    if (_count > 0) {
        [_btnSendCaptcha setTitle:[NSString stringWithFormat:@"%lds",_count] forState:UIControlStateNormal];
        _count--;
        if ([self respondsToSelector:@selector(startCountDown)]) {
            [self performSelector:@selector(startCountDown) withObject:nil afterDelay:1.0];
        }
    } else if (_count == 0) {
        [_btnSendCaptcha setTitle:@"重新获取" forState:UIControlStateNormal];
        _count = 10;
    }
}

- (void)resetCount {
    // 测试取消执行函数
    if ([self respondsToSelector:@selector(startCountDown)]) {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startCountDown) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        _count = 10;
        [_btnSendCaptcha setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

- (void)onHitBtnGetCaptcha:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        [self resetCount];
    } else {
        if ([self respondsToSelector:@selector(startCountDown)]) {
            [self performSelector:@selector(startCountDown) withObject:nil afterDelay:0.0];
        }
    }
    btn.selected = !btn.selected;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
