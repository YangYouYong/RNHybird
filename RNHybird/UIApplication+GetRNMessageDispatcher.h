//
//  UIApplication+GetRNMessageDispatcher.h
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNMessageClient.h"

@interface UIApplication (GetRNMessageDispatcher)

-(RNMessageDispatcher *)getAppRNMessageDispatcher;

@end
