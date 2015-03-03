//
//  CSAudioQueueBuffer.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CSAudioQueueBuffer : NSObject

- (instancetype)initWithAudioQueue:(AudioQueueRef)audioQueue size:(UInt32)size;

- (NSInteger)fillWithData:(const void *)data length:(UInt32)length offset:(UInt32)offset;
- (BOOL)fillWithData:(const void *)data length:(UInt32)length packetDescription:(AudioStreamPacketDescription)packetDescription;

- (void)enqueueWithAudioQueue:(AudioQueueRef)auidoQueue;
- (void)reset;

- (BOOL)isEqual:(AudioQueueBufferRef)audioQueueBuffer;

- (void)freeFromAudioQueue:(AudioQueueRef)audioQueue;

@end
