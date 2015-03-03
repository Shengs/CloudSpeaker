//
//  CSAudioStreamerConstants.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSAudioStreamerConstants.h"

NSString *const CSAudioStreamerDidChangeAudioNotification = @"CSAudioStreamerDidChangeAudioNotification";
NSString *const CSAudioStreamerDidPauseNotification = @"CSAudioStreamerDidPauseNotification";
NSString *const CSAudioStreamerDidPlayNotification = @"CSAudioStreamerDidPlayNotification";
NSString *const CSAudioStreamerDidStopNotification = @"CSAudioStreamerDidStopNotification";

NSString *const CSAudioStreamerNextTrackRequestNotification = @"CSAudioStreamerNextTrackRequestNotification";
NSString *const CSAudioStreamerPreviousTrackRequestNotification = @"CSAudioStreamerPreviousTrackRequestNotification";

NSString *const CSAudioStreamDidFinishPlayingNotification = @"CSAudioStreamDidFinishPlayingNotification";
NSString *const CSAudioStreamDidStartPlayingNotification = @"CSAudioStreamDidStartPlayingNotification";

UInt32 const kCSAudioStreamReadMaxLength = 512;
UInt32 const kCSAudioQueueBufferSize = 2048;
UInt32 const kCSAudioQueueBufferCount = 16;
UInt32 const kCSAudioQueueStartMinimumBuffers = 8;

