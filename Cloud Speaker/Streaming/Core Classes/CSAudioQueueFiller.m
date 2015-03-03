//
//  CSAudioQueueFiller.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSAudioQueueFiller.h"
#import "CSAudioQueueBuffer.h"
#import "CSAudioQueue.h"

@implementation CSAudioQueueFiller

+ (void)fillAudioQueue:(CSAudioQueue *)audioQueue withData:(const void *)data length:(UInt32)length offset:(UInt32)offset
{
    CSAudioQueueBuffer *audioQueueBuffer = [audioQueue nextFreeBuffer];
    
    NSInteger leftovers = [audioQueueBuffer fillWithData:data length:length offset:offset];
    
    if (leftovers == 0) return;
    
    [audioQueue enqueue];
    
    if (leftovers > 0)
        [self fillAudioQueue:audioQueue withData:data length:length offset:(length - (UInt32)leftovers)];
}

+ (void)fillAudioQueue:(CSAudioQueue *)audioQueue withData:(const void *)data length:(UInt32)length packetDescription:(AudioStreamPacketDescription)packetDescription
{
    CSAudioQueueBuffer *audioQueueBuffer = [audioQueue nextFreeBuffer];
    
    BOOL hasMoreRoomForPackets = [audioQueueBuffer fillWithData:data length:length packetDescription:packetDescription];
    
    if (!hasMoreRoomForPackets) {
        [audioQueue enqueue];
        [self fillAudioQueue:audioQueue withData:data length:length packetDescription:packetDescription];
    }
}

@end
