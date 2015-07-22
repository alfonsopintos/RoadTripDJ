//
//  PlaylistHeaderView.h
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistItem.h"

@interface PlaylistHeaderView : UICollectionReusableView

@property (nonatomic, weak) IBOutlet UIImageView *blurredImageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;
@property (nonatomic, weak) IBOutlet UILabel *songLabel;

-(void)setPlaylistItem:(id<PlaylistItem>)playlistItem animated:(BOOL)animated;

@end
