//
//  CSReceiverViewController.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

@import MediaPlayer;

#import "CSReceiverViewController.h"
#import "CSSessions.h"
#import "CSAudioStreamer.h"

@interface CSReceiverViewController () <CSSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UILabel *songArtist;

@property (strong, nonatomic) CSSession *session;
@property (strong, nonatomic) CSAudioInputStreamer *inputStream;

@end

@implementation CSReceiverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.session = [[CSSession alloc] initWithPeerDisplayName:@"Guest"];
    [self.session startAdvertisingForServiceType:@"dance-party" discoveryInfo:nil];
    self.session.delegate = self;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.session stopAdvertising];
}

- (void)changeSongInfo:(NSDictionary *)info
{
    if (info[@"artwork"])
        self.albumImage.image = info[@"artwork"];
    else
        self.albumImage.image = nil;
    
    self.songTitle.text = info[@"title"];
    self.songArtist.text = info[@"artist"];
}

#pragma mark - TDSessionDelegate

- (void)session:(CSSession *)session didReceiveData:(NSData *)data
{
    NSDictionary *info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self performSelectorOnMainThread:@selector(changeSongInfo:) withObject:info waitUntilDone:NO];
}

- (void)session:(CSSession *)session didReceiveAudioStream:(NSInputStream *)stream
{
    if (!self.inputStream) {
        self.inputStream = [[CSAudioInputStreamer alloc] initWithInputStream:stream];
        [self.inputStream start];
    }
}

@end