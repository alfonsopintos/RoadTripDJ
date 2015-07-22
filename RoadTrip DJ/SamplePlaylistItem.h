//
//  SamplePlaylistItem.h
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaylistItem.h"

@interface SamplePlaylistItem : NSObject <PlaylistItem>

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *song;

- (instancetype)initWithImage:(UIImage *)image artist:(NSString *)artist song:(NSString *)song;

@end
