//
//  CSAudioQueueController.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSAudioQueueController.h"

@implementation CSAudioQueueController

+ (OSStatus)playAudioQueue:(AudioQueueRef)audioQueue
{
    return AudioQueueStart(audioQueue, NULL);
}

+ (OSStatus)pauseAudioQueue:(AudioQueueRef)audioQueue
{
    return AudioQueuePause(audioQueue);
}

+ (OSStatus)stopAudioQueue:(AudioQueueRef)audioQueue
{
    return [self stopAudioQueue:audioQueue immediately:YES];
}

+ (OSStatus)finishAudioQueue:(AudioQueueRef)audioQueue
{
    return [self stopAudioQueue:audioQueue immediately:NO];
}

+ (OSStatus)stopAudioQueue:(AudioQueueRef)audioQueue immediately:(BOOL)immediately
{
    return AudioQueueStop(audioQueue, immediately);
}

@end
