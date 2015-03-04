//
//  CSAudioInputStreamer.h
//  Cloud Speaker
//
//  Created by chaos on 3/4/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSAudioInputStreamer : NSObject

@property (assign, nonatomic) UInt32 audioStreamReadMaxLength;
@property (assign, nonatomic) UInt32 audioQueueBufferSize;
@property (assign, nonatomic) UInt32 audioQueueBufferCount;

- (instancetype)initWithInputStream:(NSInputStream *)inputStream;

- (void)start;
- (void)resume;
- (void)pause;
- (void)stop;

@end
