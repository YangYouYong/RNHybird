//
//  RNMessageClient.m
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import "RNMessageDispatcher.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

@interface RNMessageDispatcher()

@property (nonatomic, weak) RCTRootView *reactNativeInstance;   // 消息的入口
@property (nonatomic, strong) NSHashTable *clients;
@property (nonatomic, strong) NSMutableDictionary *callBackClientMap;

@end

@implementation RNMessageDispatcher

+(instancetype)sharedInstance {
    static RNMessageDispatcher *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RNMessageDispatcher alloc] init];
        instance.clients = [NSHashTable weakObjectsHashTable];
        instance.callBackClientMap = @{}.mutableCopy;
    });
    return instance;
}

-(void)registerReactNativeBridgeModule {
    if (self.reactNativeInstance) {
        [self.reactNativeInstance.bridge.eventDispatcher sendAppEventWithName:@"UpdateNativeModule"
                                                                         body:@{@"moduleList":[self moduleList],@"errorCode":@"0",@"msg":@"成功"}];
    }
}

-(void)addNativeBridgeModule:(id<RNMessageClient>)module {
    [self.clients addObject:module];
    [self registerReactNativeBridgeModule];
}

-(void)removeNativeBridgeModule:(id<RNMessageClient>)module {
    
    [self.clients removeObject:module];
    [self registerReactNativeBridgeModule];
}

-(void)setReactNativeInstance:(RCTRootView *)instanceView {
    if (self.reactNativeInstance != nil) {
        NSParameterAssert("Should just register one instance listen native messages");
        return ;
    }
    _reactNativeInstance = instanceView;
}

-(void)addDelegate:(id<RNMessageClient>)delegate {
    [self.clients addObject:delegate];
}

-(void)didReceiveReactNativeMessage:(NSDictionary *)message {
    
    NSString *messageType = message[@"messageType"];
    NSString *messageId = message[@"messageId"];
    if ([messageType isEqualToString:@"CALL_BACK"]) {
        NSDictionary *callBackEntity = self.callBackClientMap[messageId];
        NSString *selPointer = callBackEntity[@"function"];
        SEL method = NSSelectorFromString(selPointer);
        id<RNMessageClient> client = callBackEntity[@"client"];
        [client performSelector:method withObject:message];
        return;
    }
    
    [[[self.clients objectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id<RNMessageClient>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj didReceiveReactNativeMessage:message];
    }];
}

-(RCTRootView *)getCurrentReactNativeInstance {
    return self.reactNativeInstance;
}

-(void)sendMessageToReactNative:(NSDictionary *)message
             registerCallBackID:(NSString *)messageCallBackId
                 callBackMethod:(SEL)callBackMethod
                      forClient:(id<RNMessageClient>)callBackClient {
    // mark message and register call back id
    NSString *callBackMethodName = NSStringFromSelector(callBackMethod);
    self.callBackClientMap[messageCallBackId] = @{@"client":callBackClient,@"function":callBackMethodName};
    [self.reactNativeInstance.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":message,@"errorCode":@"0",@"msg":@"成功"}];
}

-(NSArray *)moduleList {
    __block NSMutableArray *arr = @[].mutableCopy;
    [[[self.clients objectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id<RNMessageClient>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *moduleIdentifier = @{}.mutableCopy;
        moduleIdentifier[@"moduleName"] = [obj bridgeModuleName];
        moduleIdentifier[@"moduleId"] = [obj bridgeModuleId];
        [arr addObject:moduleIdentifier];
    }];
    return arr;
}

@end
