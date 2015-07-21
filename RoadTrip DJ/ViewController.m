//
//  ViewController.m
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/9/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import "ViewController.h"
@import MediaPlayer;

@interface ViewController () <MPMediaPickerControllerDelegate>

@property (nonatomic, strong) MPMediaItemCollection *playlist;
@property (nonatomic, strong) MPMusicPlayerController *player;
@property (nonatomic, weak) IBOutlet UIToolbar *playerBar;
@property (nonatomic, strong) UIBarButtonItem *playButton;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[MPMusicPlayerController alloc] init];
}

- (UIBarButtonItem *)playButtonItemForPlaybackState:(MPMusicPlaybackState)state {
    UIBarButtonSystemItem systemItem;
    if (state == MPMusicPlaybackStatePlaying) {
        systemItem = UIBarButtonSystemItemPause;
    } else {
        systemItem = UIBarButtonSystemItemPlay;
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:@selector(playPause:)];
    return buttonItem;
}

-(void)setPlayButtonForPlaybackState:(MPMusicPlaybackState)state{
    NSMutableArray *barButtonItems = [self.playerBar.items mutableCopy];
    NSUInteger index = [barButtonItems indexOfObjectIdenticalTo:self.playButton];
    [barButtonItems removeObjectAtIndex:index];
    [barButtonItems insertObject:[self playButtonItemForPlaybackState:state]
                         atIndex:index];
    [self.playerBar setItems:barButtonItems];
}

-(void)togglePlayPause {
    if (self.player.playbackState == MPMusicPlaybackStatePlaying) {
        NSLog(@"pausing");
        [self.player pause];
    } else {
        NSLog(@"playing");
        [self.player play];
    }
    [self setPlayButtonForPlaybackState:self.player.playbackState];
}

#pragma mark - Actions

- (IBAction)playPause:(id)sender {
    NSLog(@"%ld", (long)self.player.playbackState);
    self.playButton = sender;
    [self togglePlayPause];
}

- (IBAction)addMusic:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.prompt = @"Add music to your playlist";
    mediaPicker.showsCloudItems = YES;
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    [self presentViewController:mediaPicker animated:YES completion:Nil];
}

#pragma mark - MPMediaPickerControllerDelegate

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if (!self.playlist) {
        self.playlist = mediaItemCollection;
    } else {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:self.playlist.count + mediaItemCollection.count];
        [items addObjectsFromArray:mediaItemCollection.items];
        MPMediaItemCollection *collection = [MPMediaItemCollection collectionWithItems:items];
        self.playlist = collection;
    }
    
    int index = 1;
    for (MPMediaItem *item in self.playlist.items) {
        NSLog(@"%d) %@ - %@", index++, item.artist, item.title);
    }
    
    [self.player setQueueWithItemCollection:self.playlist];
    if (!self.player.playbackState != MPMusicPlaybackStatePlaying) {
        [self.player play];
    }
    [self.player play];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)mediaPickerDidCancel:(nonnull MPMediaPickerController *)mediaPicker {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end