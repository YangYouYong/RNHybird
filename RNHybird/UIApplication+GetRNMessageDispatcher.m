///
//  UIApplication+GetRNMessageDispatcher.m
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import "UIApplication+GetRNMessageDispatcher.h"
@implementation UIApplication (GetRNMessageDispatcher)

-(RNMessageDispatcher *)getAppRNMessageDispatcher {
    return [RNMessageDispatcher sharedInstance];
}

@end
