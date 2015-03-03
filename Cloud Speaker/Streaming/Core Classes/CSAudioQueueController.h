//
//  CSAudioQueueController.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CSAudioQueueController : NSObject

+ (OSStatus)playAudioQueue:(AudioQueueRef)audioQueue;
+ (OSStatus)pauseAudioQueue:(AudioQueueRef)audioQueue;
+ (OSStatus)stopAudioQueue:(AudioQueueRef)audioQueue;
+ (OSStatus)finishAudioQueue:(AudioQueueRef)audioQueue;

@end
