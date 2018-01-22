//
//  UIViewController+RNBridgeClient.h
//  RNHybird
//
//  Created by yangyouyong on 2018/1/22.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (RNBridgeClient)

@property (nonatomic, strong) NSString *reactnativeUniqueIdentifier;

-(NSString *)bridgeModuleName;
-(NSString *)bridgeModuleId;

@end
