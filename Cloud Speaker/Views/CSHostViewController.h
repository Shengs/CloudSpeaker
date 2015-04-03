//
//  CSHostViewController.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayListViewViewController.h"

@import MediaPlayer;
@import MultipeerConnectivity;
@import AVFoundation;

#import "CSHostViewController.h"
#import "CSAudioStreamer.h"
#import "CSSessions.h"


@interface CSHostViewController : UIViewController <MPMediaPickerControllerDelegate,PlayListViewDelegate>{
    
    IBOutlet  UIButton *_playPauseButton;
    
    IBOutlet  UILabel *_currentlyPlayingSong;
    
    IBOutlet  UITableView *_songTableView;
    
    IBOutlet  UISlider *_volumeSlider;
    
    IBOutlet UIButton *playPauseButton;
    MPMediaItemCollection	*_userMediaItemCollection;
    
    PlayListView *_playListView;
    
    NSMutableArray *allGuestsArray;
    
    BOOL playBool;
    
}

@property (nonatomic,strong) MPMusicPlayerController *musicPlayer;
@property (strong, nonatomic) MPMediaItem *song;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer2;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer3;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer4;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer5;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer6;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer7;
@property (strong, nonatomic) CSAudioOutputStreamer *outputStreamer8;

@property (strong, nonatomic) NSMutableArray *allGuestsArray;


@property (nonatomic, strong) AVAudioPlayer* player;

@property (strong, nonatomic) CSSession *session;

- (IBAction)playPauseAction:(id)sender;

- (IBAction)playPauseMusic:(id)sender;
- (IBAction)playNextSongInList:(id)sender;
- (IBAction)playPreviousSongInList:(id)sender;
- (IBAction)repeatSongList:(id)sender;
- (IBAction)shuffleSongList:(id)sender;
- (IBAction)changeVolume:(id)sender;
- (IBAction)selectSongs:(id)sender;
- (IBAction)selectPlayList:(id)sender;

- (void)removeMusicPlayerObserver;
- (void)addMusicPlayerObserver;
- (void)initializeMusicPlayer;
- (void)clearMusicList;


@end