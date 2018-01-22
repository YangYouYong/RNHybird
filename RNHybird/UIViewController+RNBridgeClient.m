//
//  UIViewController+RNBridgeClient.m
//  RNHybird
//
//  Created by yangyouyong on 2018/1/22.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import "UIViewController+RNBridgeClient.h"
#import <objc/runtime.h>

static const void * reactnativeUniqueIdentifierKey = &reactnativeUniqueIdentifierKey;

@implementation UIViewController (RNBridgeClient)

-(NSString *)reactnativeUniqueIdentifier {
    NSString *identifier = objc_getAssociatedObject(self, reactnativeUniqueIdentifierKey);
    if (!identifier) {
        identifier = [self createReactNativeUniqueIdentifier];
        [self setReactnativeUniqueIdentifier:identifier];
    }
    return identifier;
}

-(void)setReactnativeUniqueIdentifier:(NSString *)reactnativeUniqueIdentifier {
    if (reactnativeUniqueIdentifierKey) {
        objc_setAssociatedObject(self,
                                 reactnativeUniqueIdentifierKey,
                                 reactnativeUniqueIdentifier,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(NSString *)createReactNativeUniqueIdentifier {
    NSString *datestemp = [NSString stringWithFormat:@"%.2f",[[NSDate date] timeIntervalSince1970]];
    NSInteger random = arc4random() % 10000;
    NSString *identifier = [NSString stringWithFormat:@"%@_%ld_%@",
                                                        datestemp,
                                                        random,
                                                        NSStringFromClass([self class])];
    return identifier;
}

#pragma mark - RNMessageClient
-(NSString *)bridgeModuleName {
    return NSStringFromClass([self class]);
}

-(NSString *)bridgeModuleId {
    return self.reactnativeUniqueIdentifier;
}

@end
