//
//  PlaylistHeaderView.m
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import "PlaylistHeaderView.h"

@implementation PlaylistHeaderView

-(void)setPlaylistItem:(id<PlaylistItem>)playlistItem animated:(BOOL)animated {
    void (^updateBlock)() = ^{
        self.artistLabel.text = [playlistItem artist];
        self.songLabel.text = [playlistItem song];
        self.blurredImageView.image = [playlistItem image];
        self.imageView.image = [playlistItem image];
    };
    
    if (animated) {
        [UIView animateWithDuration:0.4 animations:updateBlock];
    } else {
        updateBlock();
    }
}

@end
