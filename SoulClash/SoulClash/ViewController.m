//
//  ViewController.m
//  SoulClash
//
//  Created by 冯东旺 on 2018/7/13.
//  Copyright © 2018年 冯东旺. All rights reserved.
//

#import "ViewController.h"
#import "SCPushViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(ddd) forControlEvents:(UIControlEventTouchUpInside)];
    btn.frame = CGRectMake(50, 100, 50, 50);
    [self.view addSubview:btn];
    
    //b的提交N内容
    
    //mm
    //mmm
    //,mm
    //mm
    //m334
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ddd {
    SCPushViewController *scVC = [[SCPushViewController alloc] init];
    [self.navigationController pushViewController:scVC animated:YES];
}

@end
