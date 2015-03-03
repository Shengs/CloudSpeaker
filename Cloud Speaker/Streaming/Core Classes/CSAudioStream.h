//
//  CSAudioStream.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CSAudioStreamEvent) {
    CSAudioStreamEventHasData,
    CSAudioStreamEventWantsData,
    CSAudioStreamEventEnd,
    CSAudioStreamEventError
};

@class CSAudioStream;

@protocol CSAudioStreamDelegate <NSObject>

@required
- (void)audioStream:(CSAudioStream *)audioStream didRaiseEvent:(CSAudioStreamEvent)event;

@end

@interface CSAudioStream : NSObject

@property (assign, nonatomic) id<CSAudioStreamDelegate> delegate;

- (instancetype)initWithInputStream:(NSInputStream *)inputStream;
- (instancetype)initWithOutputStream:(NSOutputStream *)outputStream;

- (void)open;
- (void)close;
- (UInt32)readData:(uint8_t *)data maxLength:(UInt32)maxLength;
- (UInt32)writeData:(uint8_t *)data maxLength:(UInt32)maxLength;

@end
