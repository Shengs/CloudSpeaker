//
//  CSAudioOuptStreamer.h
//  Cloud Speaker
//
//  Created by chaos on 3/4/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVURLAsset;

@interface CSAudioOutputStreamer : NSObject

- (instancetype)initWithOutputStream:(NSOutputStream *)stream;

- (void)streamAudioFromURL:(NSURL *)url;
- (void)start;
- (void)stop;

@end