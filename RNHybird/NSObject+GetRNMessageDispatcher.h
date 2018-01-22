//
//  NSObject+GetRNMessageDispatcher.h
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNMessageDispatcher.h"

@interface NSObject (GetRNMessageDispatcher)

+(RNMessageDispatcher *)getAppRNMessageDispatcher;

@end
