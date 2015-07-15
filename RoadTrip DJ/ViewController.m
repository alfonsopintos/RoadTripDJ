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

@end

@implementation ViewController

- (IBAction)addMusic:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.prompt = @"Add music to your playlist";
    mediaPicker.showsCloudItems = YES;
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    [self presentViewController:mediaPicker animated:YES completion:Nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - MPMediaPickerControllerDelegate
-(void)mediaPicker:(nonnull MPMediaPickerController *)mediaPicker didPickMediaItems:(nonnull MPMediaItemCollection *)mediaItemCollection {
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
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)mediaPickerDidCancel:(nonnull MPMediaPickerController *)mediaPicker {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self dismissViewControllerAnimated:YES completion:Nil];
}

@end