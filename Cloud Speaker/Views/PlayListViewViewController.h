//
//  PlayListViewViewController.h
//  Cloud Speaker
//
//  Created by chaos on 4/2/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol PlayListViewDelegate;

@interface PlayListView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (assign) id <PlayListViewDelegate> playListViewDelegate;

@end

@protocol PlayListViewDelegate <NSObject>

- (void)selectedPlayList:(MPMediaPlaylist*)playlist;

@end

