//
//  SCPushViewController.m
//  SoulClash
//
//  Created by 冯东旺 on 2018/7/16.
//  Copyright © 2018年 冯东旺. All rights reserved.
//

#import "SCPushViewController.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import "SCStreamingSessionConstructor.h"
#import "SCPermissionRequestor.h"
#import "SCCommanHeader.h"


@interface SCPushViewController () <SCStreamingSessionConstructorDelegate, PLMediaStreamingSessionDelegate>
@property (nonatomic, strong) PLMediaStreamingSession *streamingSession;
@property (nonatomic, strong) SCStreamingSessionConstructor *sessionConstructor;
@property (nonatomic, strong) NSURL *streamURL;
@property (nonatomic, strong) UIView *cameraPreviewView;
@property (nonatomic, strong) UIButton *startButton;


@end

@implementation SCPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self _prepareForCameraSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.streamingSession stopStreaming];
}
#pragma mark - private methods
- (void)setupSubviews {
    [self.view addSubview:self.cameraPreviewView];
    
    _startButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cameraPreviewView addSubview:button];
        [button setTitle:@"start" forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 50));
            make.bottom.equalTo(self.cameraPreviewView).with.offset(-25);
            make.centerX.equalTo(self.cameraPreviewView).with.offset(-120);
        }];
        button;
    });
    [_startButton addTarget:self action:@selector(_pressedStartButton:)
           forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 播放逻辑处理
- (void)_pressedStartButton:(UIButton *)button
{
    if (!_streamingSession.isStreamingRunning) {
        if (!_streamURL) {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"还没有获取到 streamURL 不能推流哦" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil] show];
            return;
        }
        button.enabled = NO;
        [_streamingSession startStreamingWithPushURL:_streamURL feedback:^(PLStreamStartStateFeedback feedback) {
            NSString *log = [NSString stringWithFormat:@"session start state %lu",(unsigned long)feedback];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", log);
                button.enabled = YES;
                if (PLStreamStartStateSuccess == feedback) {
                    [button setTitle:@"stop" forState:UIControlStateNormal];
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"错误" message:@"推流失败了" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil] show];
                }
            });
        }];
    } else {
        [_streamingSession stopStreaming];
        [button setTitle:@"start" forState:UIControlStateNormal];
    }
}
- (void)_prepareForCameraSetting
{
#warning 在这里填写获取推流地址的业务服务器 url
    NSURL *streamCloudURL = [NSURL URLWithString:@"your app server url"];
    _sessionConstructor = [[SCStreamingSessionConstructor alloc] initWithStreamCloudURL:streamCloudURL];
    _sessionConstructor.delegate = self;
    _streamingSession = [_sessionConstructor streamingSession];
    
    _streamingSession.delegate = self;
    SCPermissionRequestor *permission = [[SCPermissionRequestor alloc] init];
    permission.noPermission = ^{};
    permission.permissionGranted = ^{
        UIView *previewView = _streamingSession.previewView;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.cameraPreviewView insertSubview:previewView atIndex:0];
            [previewView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.and.right.equalTo(self.cameraPreviewView);
            }];
        });
    };
    [permission checkAndRequestPermission];
}
#pragma mark  - PLMediaStreamingSessionDelegate

#pragma mark  - SCStreamingSessionConstructorDelegate
- (void)SCStreamingSessionConstructor:(SCStreamingSessionConstructor *)constructor didGetStreamURL:(NSURL *)streamURL {
    
}

#pragma mark - setters and getters
- (UIView *)cameraPreviewView {
    if (!_cameraPreviewView) {
        _cameraPreviewView = [[UIView alloc] init];
        [self.view addSubview:_cameraPreviewView];
        [_cameraPreviewView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _cameraPreviewView;
}
@end
