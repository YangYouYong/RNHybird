//
//  RNMessageDispatcher.h
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTRootView.h"


/*
 
  -----------------------------------------------------        ---------------------------------------------------------------
 |                 Native APP                           |                                                                      |
 |                                                      |                                                                      |
 |   module1 \                                          |                                                                      |
 |            \                                         |                                                                      |
 |             \                                        |                                                                      |
 |   module2 -- NativeDispatcher<--->NativeBridgeClient <---> ReactNativeClient --> updateState(flux fluent or redux fluent)   |
 |             /                                        |                                                                      |
 |            /                                         |                                                                      |
 |   module3 /                                          |                                                                      |
 |                                                      |                                                                      |
 |                                                      |                                                                      |
  -----------------------------------------------------       -----------------------------------------------------------------
 
 */

@protocol RNMessageClient<NSObject>

-(void)didReceiveReactNativeMessage:(NSDictionary *)message;

-(NSString *)bridgeModuleName;  // 与RN互通互调模块名称
-(NSString *)bridgeModuleId;    // 与RN互通互调模块标识 unique

@end

// 用于接收RN端发送过来的信息
@interface RNMessageDispatcher : NSObject

+(instancetype)sharedInstance;

#pragma mark - module manager
// 初始化RN时注入需要通信的模块
-(void)registerReactNativeBridgeModule;

// 添加需要与RN通信的模块
-(void)addNativeBridgeModule:(id<RNMessageClient>)module;

// 移除需要与RN通信的模块
-(void)removeNativeBridgeModule:(id<RNMessageClient>)module;

#pragma mark - message manager
// 接收OC消息的入口
-(void)setReactNativeInstance:(RCTRootView *)instanceView;

-(void)didReceiveReactNativeMessage:(NSDictionary *)message;


-(void)sendMessageToReactNative:(NSDictionary *)message
             registerCallBackID:(NSString *)messageCallBackId
                 callBackMethod:(SEL)callBackMethod
                      forClient:(id<RNMessageClient>)callBackClient;


// 获取当前接收消息的对象
-(RCTRootView *)getCurrentReactNativeInstance;
@end
