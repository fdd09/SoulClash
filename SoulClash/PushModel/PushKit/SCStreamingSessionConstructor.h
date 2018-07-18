//
//  SCStreamingSessionConstructor.h
//  SoulClash
//
//  Created by 冯东旺 on 2018/7/16.
//  Copyright © 2018年 冯东旺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@class SCStreamingSessionConstructor;

@protocol SCStreamingSessionConstructorDelegate <NSObject>

- (void)SCStreamingSessionConstructor:(SCStreamingSessionConstructor *)constructor didGetStreamURL:(NSURL *)streamURL;

@end

@interface SCStreamingSessionConstructor : NSObject
@property (nonatomic, weak) id<SCStreamingSessionConstructorDelegate>delegate;

- (instancetype)initWithStreamCloudURL:(NSURL *)streamCloudURL;
- (PLMediaStreamingSession *)streamingSession;
- (void)stopStreaming;
@end
