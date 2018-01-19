//
//  NSObject+GetRNMessageDispatcher.m
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import "NSObject+GetRNMessageDispatcher.h"

@implementation NSObject (GetRNMessageDispatcher)

-(RNMessageDispatcher *)getAppRNMessageDispatcher {
    return [RNMessageDispatcher sharedInstance];
}

@end
