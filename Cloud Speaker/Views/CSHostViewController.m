//
//  CSHostViewController.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

@import MediaPlayer;
@import MultipeerConnectivity;
@import AVFoundation;

#import "CSHostViewController.h"
#import "CSAudioStreamer.h"
#import "CSSessions.h"
#import <AVFoundation/AVFoundation.h>

@interface CSHostViewController () <MPMediaPickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *albumImage;
@property (strong, nonatomic) IBOutlet UILabel *songTitle;
@property (strong, nonatomic) IBOutlet UILabel *songArtist;


@end

@implementation CSHostViewController

@synthesize allGuestsArray;

- (void)viewDidLoad
{
    playBool = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"pointer.png"] forState:UIControlStateNormal];
    
    // Set this in every view controller so that the back button displays back instead of the root view controller name
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [super viewDidLoad];
    self.session = [[CSSession alloc] initWithPeerDisplayName:[[ UIDevice currentDevice] name]];
    [self.session startAdvertisingForServiceType:@"dance-party" discoveryInfo:nil];
    
[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"NavBarBG.png"] forBarMetrics: UIBarMetricsDefault];
    
}

#pragma mark - Media Picker delegate

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.outputStreamer) return;
    
    self.song = mediaItemCollection.items[0];
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[@"title"] = [self.song valueForProperty:MPMediaItemPropertyTitle] ? [self.song valueForProperty:MPMediaItemPropertyTitle] : @"";
    info[@"artist"] = [self.song valueForProperty:MPMediaItemPropertyArtist] ? [self.song valueForProperty:MPMediaItemPropertyArtist] : @"";
    
    MPMediaItemArtwork *artwork = [self.song valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *image = [artwork imageWithSize:self.albumImage.frame.size];
    if (image)
        info[@"artwork"] = image;
    
    if (info[@"artwork"])
        self.albumImage.image = info[@"artwork"];
    else
        self.albumImage.image = nil;
    
    self.songTitle.text = info[@"title"];
    self.songArtist.text = info[@"artist"];
    
    [self.session sendData:[NSKeyedArchiver archivedDataWithRootObject:[info copy]]];
    
    [allGuestsArray addObject:[[UIDevice currentDevice] name]];
    NSLog(@"alguestarray!!!!!! %@", allGuestsArray);
    
    NSArray *peers = [self.session connectedPeers];
    
    //how to fix for more than one peer
    NSLog(@"peers: %@", peers);
    
    
    
    if (peers.count == 1) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        
    }
    if (peers.count == 2) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }
    if (peers.count == 3) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer3 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[2]]];
        
        [self.outputStreamer3 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self.outputStreamer3 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }
    if (peers.count == 4) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer3 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[2]]];
        
        [self.outputStreamer3 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer4 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[3]]];
        
        [self.outputStreamer4 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self.outputStreamer3 start];
        [self.outputStreamer4 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }
    if (peers.count == 5) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer3 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[2]]];
        
        [self.outputStreamer3 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer4 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[3]]];
        
        [self.outputStreamer4 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer5 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[4]]];
        
        [self.outputStreamer5 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self.outputStreamer3 start];
        [self.outputStreamer4 start];
        [self.outputStreamer5 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }
    if (peers.count == 6) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer3 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[2]]];
        
        [self.outputStreamer3 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer4 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[3]]];
        
        [self.outputStreamer4 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer5 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[4]]];
        
        [self.outputStreamer5 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer6 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[5]]];
        
        [self.outputStreamer6 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self.outputStreamer3 start];
        [self.outputStreamer4 start];
        [self.outputStreamer5 start];
        [self.outputStreamer6 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }
    if (peers.count == 7) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer3 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[2]]];
        
        [self.outputStreamer3 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer4 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[3]]];
        
        [self.outputStreamer4 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer5 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[4]]];
        
        [self.outputStreamer5 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer6 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[5]]];
        
        [self.outputStreamer6 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer7 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[6]]];
        
        [self.outputStreamer7 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self.outputStreamer3 start];
        [self.outputStreamer4 start];
        [self.outputStreamer5 start];
        [self.outputStreamer6 start];
        [self.outputStreamer7 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }
    if (peers.count == 8) {
        self.outputStreamer = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer2 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[1]]];
        
        [self.outputStreamer2 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer3 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[2]]];
        
        [self.outputStreamer3 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        self.outputStreamer4 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[3]]];
        
        [self.outputStreamer4 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer5 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[4]]];
        
        [self.outputStreamer5 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer6 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[5]]];
        
        [self.outputStreamer6 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer7 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[6]]];
        
        [self.outputStreamer7 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        self.outputStreamer8 = [[CSAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[7]]];
        
        [self.outputStreamer8 streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
        [self.outputStreamer2 start];
        [self.outputStreamer3 start];
        [self.outputStreamer4 start];
        [self.outputStreamer5 start];
        [self.outputStreamer6 start];
        [self.outputStreamer7 start];
        [self.outputStreamer8 start];
        [self streamMusicLocal:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
    }

    
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Actions

- (IBAction)invite:(id)sender
{
    [self presentViewController:[self.session browserViewControllerForSeriviceType:@"dance-party"] animated:YES completion:nil];
}



-(void)streamMusicLocal:(NSURL *)musicURL{
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error: NULL];
    [self.player play];
}




/////////this is the end for new interface/////



- (IBAction)addSongs:(id)sender
{
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [self removeMusicPlayerObserver];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (IBAction)changeVolume:(id)sender {
    
    self.musicPlayer.volume = _volumeSlider.value;
    
}

- (IBAction)playPauseAction:(id)sender {
    
    NSLog(@"playpause tapped");
    UIImage *currentImage = playPauseButton.currentImage;
    NSLog(@"%@", currentImage);
    UIImage *play = [UIImage imageNamed:@"play.png"];
    UIImage *pause = [UIImage imageNamed:@"pause.png"];
    if(currentImage == play){
        NSLog(@"is play button");
        [playPauseButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    }
    if(currentImage == pause){
        NSLog(@"is pause button");
        [playPauseButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
}
@end
