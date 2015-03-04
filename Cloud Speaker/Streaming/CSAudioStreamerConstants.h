//
//  CSAudioStreamerConstants.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const CSAudioStreamerDidChangeAudioNotification;
extern NSString *const CSAudioStreamerDidPauseNotification;
extern NSString *const CSAudioStreamerDidPlayNotification;
extern NSString *const CSAudioStreamerDidStopNotification;

extern NSString *const CSAudioStreamerNextTrackRequestNotification;
extern NSString *const CSAudioStreamerPreviousTrackRequestNotification;

extern NSString *const CSAudioStreamDidFinishPlayingNotification;
extern NSString *const CSAudioStreamDidStartPlayingNotification;

extern UInt32 const kCSAudioStreamReadMaxLength;
extern UInt32 const kCSAudioQueueBufferSize;
extern UInt32 const kCSAudioQueueBufferCount;
extern UInt32 const kCSAudioQueueStartMinimumBuffers;