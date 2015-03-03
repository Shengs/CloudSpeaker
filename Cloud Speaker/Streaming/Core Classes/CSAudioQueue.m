//
//  CSAudioQueue.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSAudioQueue.h"
#import "CSAudioQueueBuffer.h"
#import "CSAudioQueueController.h"
#import "CSAudioQueueBufferManager.h"
#import "CSAudioStreamerConstants.h"

@interface CSAudioQueue ()

@property (assign, nonatomic) AudioQueueRef audioQueue;
@property (strong, nonatomic) CSAudioQueueBufferManager *bufferManager;
@property (strong, nonatomic) NSCondition *waitForFreeBufferCondition;
@property (assign, nonatomic) NSUInteger buffersToFillBeforeStart;

- (void)didFreeAudioQueueBuffer:(AudioQueueBufferRef)audioQueueBuffer;

@end

void CSAudioQueueOutputCallback(void *inUserData, AudioQueueRef inAudioQueue, AudioQueueBufferRef inAudioQueueBuffer)
{
    CSAudioQueue *audioQueue = (__bridge CSAudioQueue *)inUserData;
    [audioQueue didFreeAudioQueueBuffer:inAudioQueueBuffer];
}

@implementation CSAudioQueue

- (instancetype)initWithBasicDescription:(AudioStreamBasicDescription)basicDescription bufferCount:(UInt32)bufferCount bufferSize:(UInt32)bufferSize magicCookieData:(void *)magicCookieData magicCookieSize:(UInt32)magicCookieSize
{
    self = [self init];
    if (!self) return nil;
    
    OSStatus err = AudioQueueNewOutput(&basicDescription, CSAudioQueueOutputCallback, (__bridge void *)self, NULL, NULL, 0, &_audioQueue);
    
    if (err) return nil;
    
    self.bufferManager = [[CSAudioQueueBufferManager alloc] initWithAudioQueue:self.audioQueue size:bufferSize count:bufferCount];
    
    AudioQueueSetProperty(self.audioQueue, kAudioQueueProperty_MagicCookie, magicCookieData, magicCookieSize);
    free(magicCookieData);
    
    AudioQueueSetParameter(self.audioQueue, kAudioQueueParam_Volume, 1.0);
    
    self.waitForFreeBufferCondition = [[NSCondition alloc] init];
    self.state = CSAudioQueueStateBuffering;
    self.buffersToFillBeforeStart = kCSAudioQueueStartMinimumBuffers;
    
    return self;
}

#pragma mark - Audio Queue Events

- (void)didFreeAudioQueueBuffer:(AudioQueueBufferRef)audioQueueBuffer
{
    [self.bufferManager freeAudioQueueBuffer:audioQueueBuffer];
    
    [self.waitForFreeBufferCondition lock];
    [self.waitForFreeBufferCondition signal];
    [self.waitForFreeBufferCondition unlock];
    
    if (self.state == CSAudioQueueStateStopped && ![self.bufferManager isProcessingAudioQueueBuffer]) {
        [self.delegate audioQueueDidFinishPlaying:self];
    }
}

#pragma mark - Public Methods

- (CSAudioQueueBuffer *)nextFreeBuffer
{
    if (![self.bufferManager hasAvailableAudioQueueBuffer]) {
        [self.waitForFreeBufferCondition lock];
        [self.waitForFreeBufferCondition wait];
        [self.waitForFreeBufferCondition unlock];
    }
    
    CSAudioQueueBuffer *nextBuffer = [self.bufferManager nextFreeBuffer];
    
    if (!nextBuffer) return [self nextFreeBuffer];
    return nextBuffer;
}

- (void)enqueue
{
    [self.bufferManager enqueueNextBufferOnAudioQueue:self.audioQueue];
    
    if (self.state == CSAudioQueueStateBuffering && --self.buffersToFillBeforeStart == 0) {
        AudioQueuePrime(self.audioQueue, 0, NULL);
        [self play];
        [self.delegate audioQueueDidStartPlaying:self];
    }
}

#pragma mark - Audio Queue Controls

- (void)play
{
    if (self.state == CSAudioQueueStatePlaying) return;
    
    [CSAudioQueueController playAudioQueue:self.audioQueue];
    self.state = CSAudioQueueStatePlaying;
}

- (void)pause
{
    if (self.state == CSAudioQueueStatePaused) return;
    
    [CSAudioQueueController pauseAudioQueue:self.audioQueue];
    self.state = CSAudioQueueStatePaused;
}

- (void)stop
{
    if (self.state == CSAudioQueueStateStopped) return;
    
    [CSAudioQueueController stopAudioQueue:self.audioQueue];
    self.state = CSAudioQueueStateStopped;
}

- (void)finish
{
    if (self.state == CSAudioQueueStateStopped) return;
    
    [CSAudioQueueController finishAudioQueue:self.audioQueue];
    self.state = CSAudioQueueStateStopped;
}

#pragma mark - Cleanup

- (void)dealloc
{
    [self.bufferManager freeBufferMemoryFromAudioQueue:self.audioQueue];
    AudioQueueDispose(self.audioQueue, YES);
}

@end

