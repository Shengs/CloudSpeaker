//
//  CSAudioQueue.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

typedef NS_ENUM(NSUInteger, CSAudioQueueState) {
    CSAudioQueueStateBuffering,
    CSAudioQueueStateStopped,
    CSAudioQueueStatePaused,
    CSAudioQueueStatePlaying
};

@class CSAudioQueue;

@protocol CSAudioQueueDelegate <NSObject>

- (void)audioQueueDidFinishPlaying:(CSAudioQueue *)audioQueue;
- (void)audioQueueDidStartPlaying:(CSAudioQueue *)audioQueue;

@end

@class CSAudioQueueBuffer;

@interface CSAudioQueue : NSObject

@property (assign, nonatomic) CSAudioQueueState state;
@property (assign, nonatomic) id<CSAudioQueueDelegate> delegate;

- (instancetype)initWithBasicDescription:(AudioStreamBasicDescription)basicDescription bufferCount:(UInt32)bufferCount bufferSize:(UInt32)bufferSize magicCookieData:(void *)magicCookieData magicCookieSize:(UInt32)magicCookieSize;

- (CSAudioQueueBuffer *)nextFreeBuffer;
- (void)enqueue;

- (void)play;
- (void)pause;
- (void)stop;
- (void)finish;

@end