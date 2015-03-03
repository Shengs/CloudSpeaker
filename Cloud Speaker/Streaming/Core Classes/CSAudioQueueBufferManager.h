//
//  CSAudioQueueBufferManager.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class CSAudioQueueBuffer;

@interface CSAudioQueueBufferManager : NSObject

- (instancetype)initWithAudioQueue:(AudioQueueRef)audioQueue size:(UInt32)size count:(UInt32)count;

- (void)freeAudioQueueBuffer:(AudioQueueBufferRef)audioQueueBuffer;
- (CSAudioQueueBuffer *)nextFreeBuffer;
- (void)enqueueNextBufferOnAudioQueue:(AudioQueueRef)audioQueue;

- (BOOL)hasAvailableAudioQueueBuffer;
- (BOOL)isProcessingAudioQueueBuffer;

- (void)freeBufferMemoryFromAudioQueue:(AudioQueueRef)audioQueue;

@end