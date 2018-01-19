//
//  TwoViewController.m
//  hunheDemo
//
//  Created by 江清清 on 16/6/5.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "TwoViewController.h"
#import <React/RCTRootView.h>
#import "ThreeViewController.h"
#import "RNBridgeModule.h"
#import "AppDelegate.h"
@implementation TwoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title=@"RN界面";
  NSURL *jsCodeLocation=[NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"hunheDemo"
                                               initialProperties:nil
                                                   launchOptions:nil];
  
  rootView.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 200);
  [self.view addSubview:rootView];
  ((AppDelegate *)[[UIApplication sharedApplication] delegate]).RNView = rootView;
  
  self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
  self.btn.frame = CGRectMake(20,  CGRectGetHeight([[UIScreen mainScreen] bounds]) - 150, 200, 100);
  self.btn.backgroundColor = [UIColor lightGrayColor];
  [self.view addSubview:self.btn];
  [self.btn
   addTarget:self
   action:@selector(sendMsgToRN:)
     forControlEvents:UIControlEventTouchUpInside];
}
- (void)sendMsgToRN:(id)sender{
//  [[((RCTRootView *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).RNView) bridge] enqueueJSCall:@"hunheDemo.nativeFunction"
//                                          args:@[@"123"]];
  
  ((RCTRootView *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).RNView).appProperties = @{@"message": @"123123"};
}

@end
