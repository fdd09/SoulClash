//
//  SCPermissionRequestor.h
//  SoulClash
//
//  Created by 冯东旺 on 2018/7/16.
//  Copyright © 2018年 冯东旺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPermissionRequestor : NSObject
@property (nonatomic, strong) void (^permissionGranted)(void);
@property (nonatomic, strong) void (^noPermission)(void);

- (instancetype)initWithPermissionGranted:(void (^)(void))permissionGranted
                         withNoPermission:(void (^)(void))noPermission;
- (void)checkAndRequestPermission;

@end
