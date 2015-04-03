//
//  CSAudioOuptStreamer.m
//  Cloud Speaker
//
//  Created by chaos on 3/4/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CSAudioOutputStreamer.h"
#import "CSAudioStream.h"

@interface CSAudioOutputStreamer () <CSAudioStreamDelegate>

@property (strong, nonatomic) CSAudioStream *audioStream;
@property (strong, nonatomic) AVAssetReader *assetReader;
@property (strong, nonatomic) AVAssetReaderTrackOutput *assetOutput;
@property (strong, nonatomic) NSThread *streamThread;

@property (assign, atomic) BOOL isStreaming;

@end

@implementation CSAudioOutputStreamer

- (instancetype) initWithOutputStream:(NSOutputStream *)stream
{
    self = [super init];
    if (!self) return nil;
    
    self.audioStream = [[CSAudioStream alloc] initWithOutputStream:stream];
    self.audioStream.delegate = self;
    NSLog(@"Init");
    
    return self;
}

- (instancetype) initWithOutputStreams:(NSMutableArray *)streamsArray
{
    self = [super init];
    if (!self) return nil;
    
    self.audioStream = [[CSAudioStream alloc] initWithOutputStream:streamsArray[0]];
    self.audioStream.delegate = self;
    NSLog(@"Init");
    
    return self;
}

- (void)start
{
    if (![[NSThread currentThread] isEqual:[NSThread mainThread]]) {
        return [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:YES];
    }
    
    NSLog(@"Start");
    self.streamThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [self.streamThread start];
}

- (void)run
{
    @autoreleasepool {
        [self.audioStream open];
        
        self.isStreaming = YES;
        NSLog(@"Loop");
        
        while (self.isStreaming && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) ;
        
        NSLog(@"Done");
    }
}

- (void)streamAudioFromURL:(NSURL *)url
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    NSError *assetError;
    
    self.assetReader = [AVAssetReader assetReaderWithAsset:asset error:&assetError];
    self.assetOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:asset.tracks[0] outputSettings:nil];
    if (![self.assetReader canAddOutput:self.assetOutput]) return;
    
    [self.assetReader addOutput:self.assetOutput];
    [self.assetReader startReading];
    NSLog(@"Read Asset");
}

- (void)sendDataChunk
{
    CMSampleBufferRef sampleBuffer;
    
    sampleBuffer = [self.assetOutput copyNextSampleBuffer];
    
    if (sampleBuffer == NULL || CMSampleBufferGetNumSamples(sampleBuffer) == 0) {
        CFRelease(sampleBuffer);
        return;
    }
    
    CMBlockBufferRef blockBuffer;
    AudioBufferList audioBufferList;
    
    OSStatus err = CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(sampleBuffer, NULL, &audioBufferList, sizeof(AudioBufferList), NULL, NULL, kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment, &blockBuffer);
    
    if (err) {
        CFRelease(sampleBuffer);
        return;
    }
    
    for (NSUInteger i = 0; i < audioBufferList.mNumberBuffers; i++) {
        AudioBuffer audioBuffer = audioBufferList.mBuffers[i];
        [self.audioStream writeData:audioBuffer.mData maxLength:audioBuffer.mDataByteSize];
        NSLog(@"buffer size: %u", (unsigned int)audioBuffer.mDataByteSize);
    }
    
    CFRelease(blockBuffer);
    CFRelease(sampleBuffer);
}

- (void)stop
{
    [self performSelector:@selector(stopThread) onThread:self.streamThread withObject:nil waitUntilDone:YES];
}

- (void)stopThread
{
    self.isStreaming = NO;
    [self.audioStream close];
    NSLog(@"Stop");
}

#pragma mark - CSAudioStreamDelegate

- (void)audioStream:(CSAudioStream *)audioStream didRaiseEvent:(CSAudioStreamEvent)event
{
    switch (event) {
        case CSAudioStreamEventWantsData:
            [self sendDataChunk];
            break;
            
        case CSAudioStreamEventError:
            // TODO: shit!
            NSLog(@"Stream Error");
            break;
            
        case CSAudioStreamEventEnd:
            // TODO: shit!
            NSLog(@"Stream Ended");
            break;
            
        default:
            break;
    }
}

@end
