//
//  ViewController.m
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/9/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import "ViewController.h"
#import "PlaylistDataSource.h"
#import "SamplePlaylistItem.h"
@import MediaPlayer;

@interface ViewController () <MPMediaPickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) MPMediaItemCollection *playlist;
@property (nonatomic, strong) MPMusicPlayerController *player;
@property (nonatomic, weak) IBOutlet UIToolbar *playerBar;
@property (nonatomic, strong) UIBarButtonItem *playButton;
@property (nonatomic, strong) IBOutlet PlaylistDataSource *playlistDataSource;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[MPMusicPlayerController alloc] init];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(-64, 0, 44, 0);
    [self.collectionView registerNib:[UINib nibWithNibName:@"PlaylistHeaderView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"header"];
    
#if TARGET_IPHONE_SIMULATOR
    NSArray *items = @[
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test123.jpg"] artist:@"Nirvana" song:@"Heart-Shaped Box"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Radiohead" song:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test123.jpg"] artist:@"Tool" song:@"Forty-six and Two"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Pink Floyd" song:@"Echoes"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test123.jpg"] artist:@"Metallica" song:@"One"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Red Hot Chili Peppers" song:@"Give it Away"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test123.jpg"] artist:@"Radiohead" song:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Pearl Jam" song:@"Ten"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test123.jpg"] artist:@"Pink Floyd" song:@"The Great Gig in the Sky"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Portishead" song:@"Strangers"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Arcade Fire" song:@"Modern Man"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Led Zeppelin" song:@"No Quarter"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"test456.jpg"] artist:@"Miles Davis" song:@"Freddie Freeloader"]
                       ];
    
    self.playlistDataSource.items = items;
#endif
    
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