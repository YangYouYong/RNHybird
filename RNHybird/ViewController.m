//
//  ViewController.m
//  RNHybird
//
//  Created by yangyouyong on 2018/1/19.
//  Copyright © 2018年 cpbee. All rights reserved.
//

#import "ViewController.h"

#import <RCTRootView.h>
#import <RCTBridgeModule.h>
#import "RNMessageDispatcher.h"
#import "UIViewController+RNBridgeClient.h"

@interface ViewController ()<RNMessageClient>

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *nativeMessageSend;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSURL *jsCodeLocation=[NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNHybird"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    rootView.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 200);
    [self.view addSubview:rootView];
    
    [[RNMessageDispatcher sharedInstance] setReactNativeInstance:rootView];
    [[RNMessageDispatcher sharedInstance] addNativeBridgeModule:self];
    [super viewDidLoad];
    
    self.nativeMessageSend = [UIButton new];
    [self.view addSubview:self.nativeMessageSend];
    self.nativeMessageSend.frame = CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]) - 200, CGRectGetWidth([[UIScreen mainScreen] bounds]), 50);
    [self.nativeMessageSend setTitle:@"原生发送消息给RN" forState:UIControlStateNormal];
    [self.nativeMessageSend setBackgroundColor:[UIColor brownColor]];
    [self.nativeMessageSend addTarget:self action:@selector(sendMessageToReactNative) forControlEvents:UIControlEventTouchUpInside];
    
    self.messageLabel = [UILabel new];
    [self.view addSubview:self.messageLabel];
    self.messageLabel.frame = CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]) - 150, CGRectGetWidth([[UIScreen mainScreen] bounds]), 150);
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = [UIFont systemFontOfSize:14];
    self.messageLabel.textColor = [UIColor brownColor];
    self.messageLabel.backgroundColor = [UIColor lightGrayColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)sendMessageToReactNative {
    NSDictionary *messageContent = @{@"messageId":@"123456",
                                     @"messageType":@"IM_Message",
                                     @"needCallBack":@1,
                                     @"content":@"haha"};
    NSString *messageId = messageContent[@"messageId"];
    [[RNMessageDispatcher sharedInstance] sendMessageToReactNative:messageContent
                                                registerCallBackID:messageId
                                                    callBackMethod:@selector(rncallBack:)
                                                         forClient:self];
    
}

-(void)rncallBack:(NSDictionary *)message {
    
    NSLog(@"viewController receive callBack: %@",message);
    NSString *firstKey = [message allKeys].firstObject;
    id value = message[firstKey];
    NSString *messageContent = [NSString stringWithFormat:@"newMessage:%@,content:%@",firstKey,value];
    NSString *originalText = self.messageLabel.text.length > 0? self.messageLabel.text : @"";
    self.messageLabel.text = [originalText stringByAppendingString:messageContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didReceiveReactNativeMessage:(NSDictionary *)message {
    
    NSLog(@"viewController receive: %@",message);
    NSString *firstKey = [message allKeys].firstObject;
    id value = message[firstKey];
    NSString *messageContent = [NSString stringWithFormat:@"newMessage:%@,content:%@",firstKey,value];
    NSString *originalText = self.messageLabel.text.length > 0? self.messageLabel.text : @"";
    self.messageLabel.text = [originalText stringByAppendingString:messageContent];
}

@end
