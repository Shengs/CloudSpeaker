//
//  CSAudioStream.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSAudioStream.h"

@interface CSAudioStream () <NSStreamDelegate>

@property (strong, nonatomic) NSStream *stream;

@end

@implementation CSAudioStream

- (instancetype)initWithInputStream:(NSInputStream *)inputStream
{
    self = [super init];
    if (!self) return nil;
    
    self.stream = inputStream;
    
    return self;
}

- (instancetype)initWithOutputStream:(NSOutputStream *)outputStream
{
    self = [super init];
    if (!self) return nil;
    
    self.stream = outputStream;
    
    return self;
}

- (void)open
{
    self.stream.delegate = self;
    [self.stream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    return [self.stream open];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable:
            [self.delegate audioStream:self didRaiseEvent:CSAudioStreamEventHasData];
            break;
            
        case NSStreamEventHasSpaceAvailable:
            [self.delegate audioStream:self didRaiseEvent:CSAudioStreamEventWantsData];
            break;
            
        case NSStreamEventEndEncountered:
            [self.delegate audioStream:self didRaiseEvent:CSAudioStreamEventEnd];
            break;
            
        case NSStreamEventErrorOccurred:
            [self.delegate audioStream:self didRaiseEvent:CSAudioStreamEventError];
            break;
            
        default:
            break;
    }
}

- (UInt32)readData:(uint8_t *)data maxLength:(UInt32)maxLength
{
    return (UInt32)[(NSInputStream *)self.stream read:data maxLength:maxLength];
}

- (UInt32)writeData:(uint8_t *)data maxLength:(UInt32)maxLength
{
    return (UInt32)[(NSOutputStream *)self.stream write:data maxLength:maxLength];
}

- (void)close
{
    [self.stream close];
    self.stream.delegate = nil;
    [self.stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)dealloc
{
    if (self.stream)
        [self close];
}

@end

