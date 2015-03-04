//
//  CSAudioInputStreamer.m
//  Cloud Speaker
//
//  Created by chaos on 3/4/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSAudioInputStreamer.h"
#import "CSAudioFileStream.h"
#import "CSAudioStream.h"
#import "CSAudioQueue.h"
#import "CSAudioQueueBuffer.h"
#import "CSAudioQueueFiller.h"
#import "CSAudioStreamerConstants.h"

@interface CSAudioInputStreamer () <CSAudioStreamDelegate, CSAudioFileStreamDelegate, CSAudioQueueDelegate>

@property (strong, nonatomic) NSThread *audioStreamerThread;
@property (assign, atomic) BOOL isPlaying;

@property (strong, nonatomic) CSAudioStream *audioStream;
@property (strong, nonatomic) CSAudioFileStream *audioFileStream;
@property (strong, nonatomic) CSAudioQueue *audioQueue;

@end

@implementation CSAudioInputStreamer

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    self.audioFileStream = [[CSAudioFileStream alloc] init];
    if (!self.audioFileStream) return nil;
    
    self.audioFileStream.delegate = self;
    
    return self;
}

- (instancetype)initWithInputStream:(NSInputStream *)inputStream
{
    self = [self init];
    if (!self) return nil;
    
    self.audioStream = [[CSAudioStream alloc] initWithInputStream:inputStream];
    if (!self.audioStream) return nil;
    
    self.audioStream.delegate = self;
    
    return self;
}

- (void)start
{
    if (![[NSThread currentThread] isEqual:[NSThread mainThread]]) {
        return [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:YES];
    }
    
    self.audioStreamerThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [self.audioStreamerThread start];
}

- (void)run
{
    @autoreleasepool {
        [self.audioStream open];
        
        self.isPlaying = YES;
        
        while (self.isPlaying && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) ;
    }
}

#pragma mark - Properties

- (UInt32)audioStreamReadMaxLength
{
    if (!_audioStreamReadMaxLength)
        _audioStreamReadMaxLength = kCSAudioStreamReadMaxLength;
    
    return _audioStreamReadMaxLength;
}

- (UInt32)audioQueueBufferSize
{
    if (!_audioQueueBufferSize)
        _audioQueueBufferSize = kCSAudioQueueBufferSize;
    
    return _audioQueueBufferSize;
}

- (UInt32)audioQueueBufferCount
{
    if (!_audioQueueBufferCount)
        _audioQueueBufferCount = kCSAudioQueueBufferCount;
    
    return _audioQueueBufferCount;
}

#pragma mark - CSAudioStreamDelegate

- (void)audioStream:(CSAudioStream *)audioStream didRaiseEvent:(CSAudioStreamEvent)event
{
    switch (event) {
        case CSAudioStreamEventHasData: {
            uint8_t bytes[self.audioStreamReadMaxLength];
            UInt32 length = [audioStream readData:bytes maxLength:self.audioStreamReadMaxLength];
            [self.audioFileStream parseData:bytes length:length];
            break;
        }
            
        case CSAudioStreamEventEnd:
            self.isPlaying = NO;
            [self.audioQueue finish];
            break;
            
        case CSAudioStreamEventError:
            [[NSNotificationCenter defaultCenter] postNotificationName:CSAudioStreamDidFinishPlayingNotification object:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - CSAudioFileStreamDelegate

- (void)audioFileStreamDidBecomeReady:(CSAudioFileStream *)audioFileStream
{
    UInt32 bufferSize = audioFileStream.packetBufferSize ? audioFileStream.packetBufferSize : self.audioQueueBufferSize;
    
    self.audioQueue = [[CSAudioQueue alloc] initWithBasicDescription:audioFileStream.basicDescription bufferCount:self.audioQueueBufferCount bufferSize:bufferSize magicCookieData:audioFileStream.magicCookieData magicCookieSize:audioFileStream.magicCookieLength];
    
    self.audioQueue.delegate = self;
}

- (void)audioFileStream:(CSAudioFileStream *)audioFileStream didReceiveError:(OSStatus)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CSAudioStreamDidFinishPlayingNotification object:nil];
}

- (void)audioFileStream:(CSAudioFileStream *)audioFileStream didReceiveData:(const void *)data length:(UInt32)length
{
    [CSAudioQueueFiller fillAudioQueue:self.audioQueue withData:data length:length offset:0];
}

- (void)audioFileStream:(CSAudioFileStream *)audioFileStream didReceiveData:(const void *)data length:(UInt32)length packetDescription:(AudioStreamPacketDescription)packetDescription
{
    [CSAudioQueueFiller fillAudioQueue:self.audioQueue withData:data length:length packetDescription:packetDescription];
}

#pragma mark - CSAudioQueueDelegate

- (void)audioQueueDidFinishPlaying:(CSAudioQueue *)audioQueue
{
    [self performSelectorOnMainThread:@selector(notifyMainThread:) withObject:CSAudioStreamDidFinishPlayingNotification waitUntilDone:NO];
}

- (void)audioQueueDidStartPlaying:(CSAudioQueue *)audioQueue
{
    [self performSelectorOnMainThread:@selector(notifyMainThread:) withObject:CSAudioStreamDidStartPlayingNotification waitUntilDone:NO];
}

- (void)notifyMainThread:(NSString *)notificationName
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

#pragma mark - Public Methods

- (void)resume
{
    [self.audioQueue play];
}

- (void)pause
{
    [self.audioQueue pause];
}

- (void)stop
{
    [self performSelector:@selector(stopThread) onThread:self.audioStreamerThread withObject:nil waitUntilDone:YES];
}

- (void)stopThread
{
    self.isPlaying = NO;
    [self.audioQueue stop];
}

@end

