//
//  CSAudioQueueFiller.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class CSAudioQueue;

@interface CSAudioQueueFiller : NSObject

+ (void)fillAudioQueue:(CSAudioQueue *)audioQueue withData:(const void *)data length:(UInt32)length offset:(UInt32)offset;
+ (void)fillAudioQueue:(CSAudioQueue *)audioQueue withData:(const void *)data length:(UInt32)length packetDescription:(AudioStreamPacketDescription)packetDescription;

@end
