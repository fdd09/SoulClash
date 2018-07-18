//
//  SCPermissionRequestor.m
//  SoulClash
//
//  Created by 冯东旺 on 2018/7/16.
//  Copyright © 2018年 冯东旺. All rights reserved.
//

#import "SCPermissionRequestor.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@implementation SCPermissionRequestor
- (instancetype)initWithPermissionGranted:(void (^)())permissionGranted
                         withNoPermission:(void (^)())noPermission
{
    if (self = [self init]) {
        _permissionGranted = permissionGranted;
        _noPermission = noPermission;
    }
    return self;
}

- (void)checkAndRequestPermission
{
    PLAuthorizationStatus status = [PLMediaStreamingSession cameraAuthorizationStatus];
    
    if (PLAuthorizationStatusNotDetermined == status) {
        [PLMediaStreamingSession requestCameraAccessWithCompletionHandler:^(BOOL granted) {
            granted ? _permissionGranted() : _noPermission();
        }];
    } else if (PLAuthorizationStatusAuthorized == status) {
        _permissionGranted();
    } else {
        _noPermission();
    }
}
@end
