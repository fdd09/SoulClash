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
    //7
    //m8
    //m9
    //m10
    //m11
    //m12
//<<<<<<< HEAD
    //c5
//=======
    //m13
    //m14
//>>>>>>> master
    //15
    //16
    //17
    //18
    //19
    //20
    //21
    //m22
    //23
    //24
    //25
    //26
    //27
    //28
    //29
    //30
    //31
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
