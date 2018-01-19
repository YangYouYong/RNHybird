//
//  RNMessageClient.h
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTRootView.h"

@protocol RNMessageClient<NSObject>

-(void)didReceiveReactNativeMessage:(NSDictionary *)message;

@end

// 用于接收RN端发送过来的信息
@interface RNMessageDispatcher : NSObject

+(instancetype)sharedInstance;

// 接收OC消息的入口
-(void)setReactNativeInstance:(RCTRootView *)instanceView;

-(void)addDelegate:(id<RNMessageClient>)delegate;

-(void)didReceiveReactNativeMessage:(NSDictionary *)message;

// 获取当前接收消息的对象
-(RCTRootView *)getCurrentReactNativeInstance;

-(void)sendMessageToReactNative:(NSDictionary *)message
             registerCallBackID:(NSString *)messageCallBackId
                 callBackMethod:(SEL)callBackMethod
                      forClient:(id<RNMessageClient>)callBackClient;

@end
