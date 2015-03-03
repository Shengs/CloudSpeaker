//
//  CSAudioFileStream.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class CSAudioFileStream;
@protocol CSAudioFileStreamDelegate <NSObject>

- (void)audioFileStream:(CSAudioFileStream *)audioFileStream didReceiveError:(OSStatus)error;

@required
- (void)audioFileStreamDidBecomeReady:(CSAudioFileStream *)audioFileStream;
- (void)audioFileStream:(CSAudioFileStream *)audioFileStream didReceiveData:(const void *)data length:(UInt32)length packetDescription:(AudioStreamPacketDescription)packetDescription;
- (void)audioFileStream:(CSAudioFileStream *)audioFileStream didReceiveData:(const void *)data length:(UInt32)length;

@end

@interface CSAudioFileStream : NSObject

@property (assign, nonatomic) AudioStreamBasicDescription basicDescription;
@property (assign, nonatomic) UInt64 totalByteCount;
@property (assign, nonatomic) UInt32 packetBufferSize;
@property (assign, nonatomic) void *magicCookieData;
@property (assign, nonatomic) UInt32 magicCookieLength;
@property (assign, nonatomic) BOOL discontinuous;
@property (assign, nonatomic) id<CSAudioFileStreamDelegate> delegate;

- (instancetype)init;

- (void)parseData:(const void *)data length:(UInt32)length;

@end
