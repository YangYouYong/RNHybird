//
//  RNBridgeModuleClient.m
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import "RNBridgeModuleClient.h"

#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import "UIApplication+GetRNMessageDispatcher.h"
#import "NSObject+GetRNMessageDispatcher.h"

@implementation RNBridgeModuleClient

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(RNBridgeModuleClient)


//RN传参数调用原生OC,并且返回数据给RN  通过CallBack
RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionary callback:(RCTResponseSenderBlock)callback){
    NSLog(@"接收到RN传过来的数据为:%@",dictionary);
    NSArray *events = [[NSArray alloc] initWithObjects:@"张三",@"李四", nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        //    + (UIViewController*)byb_topViewController {
//        UIWindow *window = [UIApplication sharedApplication].delegate.window;
//        BOOL hasPresent = true;
//        UIViewController *obj = window.rootViewController;
//        while (hasPresent) {
//            hasPresent = obj.parentViewController != nil ? true : false;
//            if (hasPresent) {
//                obj = obj.parentViewController;
//            }
//        }
        
        [[[UIApplication sharedApplication] getAppRNMessageDispatcher] didReceiveReactNativeMessage:dictionary];
        
//        NSLog(@"oc receive: %@",dictionary);
        //    [(UINavigationController *)obj popViewControllerAnimated:true];
        //    UINavigationController *nv =
//        NSLog(@"%@",((UINavigationController *)obj).topViewController);
//        [((TwoViewController *)((UINavigationController *)obj).topViewController).btn
//         setTitle:dictionary[@"description"]
//         forState:UIControlStateNormal];
        
        callback(@[[NSNull null], events]);
    });
}
//RN传参数调用原生OC,并且返回数据给RN  通过Promise
RCT_EXPORT_METHOD(RNInvokeOCPromise:(NSDictionary *)dictionary resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    NSLog(@"接收到RN传过来的数据为:%@",dictionary);
    NSString *value=[dictionary objectForKey:@"name"];
    if([value isEqualToString:@"jiangqq"]){
        resolve(@"回调成功啦,Promise...");
    }else{
        NSError *error=[NSError errorWithDomain:@"传入的name不符合要求,回调失败啦,Promise..." code:100 userInfo:nil];
        reject(@"100",@"传入的name不符合要求,回调失败啦,Promise...",error);
    }
}
//RN跳转原生界面
RCT_EXPORT_METHOD(RNOpenVC:(NSString *)msg){
   NSLog(@"RN传入原生界面的数据为:%@",msg);
  [[NSNotificationCenter defaultCenter]postNotificationName:@"RNOpenVC" object:nil];
}

//OC调用RN
RCT_EXPORT_METHOD(VCOpenRN:(NSDictionary *)dictionary){
    NSString *value=[dictionary objectForKey:@"name"];
    if([value isEqualToString:@"jiangqq"]){
        [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":[NSString stringWithFormat:@"%@",value],@"errorCode":@"0",@"msg":@"成功"}];
    }else{
        [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":[NSString stringWithFormat:@"%@",value],@"errorCode":@"0",@"msg":@"输入的name不是jiangqq"}];
    }
}


RCT_EXPORT_METHOD(RNSendMessage:(NSDictionary *)dictionary){
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] getAppRNMessageDispatcher] didReceiveReactNativeMessage:dictionary];
    });
}


@end
