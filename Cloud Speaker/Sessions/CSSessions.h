//
//  CSSessions.h
//  Cloud Speaker
//
//  Created by chaos on 3/4/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSSession, MCPeerID, MCBrowserViewController;
@protocol CSSessionDelegate <NSObject>

- (void)session:(CSSession *)session didReceiveAudioStream:(NSInputStream *)stream;
- (void)session:(CSSession *)session didReceiveData:(NSData *)data;

@end

@interface CSSession : NSObject

@property (weak, nonatomic) id<CSSessionDelegate> delegate;

- (instancetype)initWithPeerDisplayName:(NSString *)name;

- (void)startAdvertisingForServiceType:(NSString *)type discoveryInfo:(NSDictionary *)info;
- (void)stopAdvertising;
- (MCBrowserViewController *)browserViewControllerForSeriviceType:(NSString *)type;

- (NSArray *)connectedPeers;
- (NSOutputStream *)outputStreamForPeer:(MCPeerID *)peer;

- (void)sendData:(NSData *)data;

@end
