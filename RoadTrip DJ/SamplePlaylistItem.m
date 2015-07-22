//
//  SamplePlaylistItem.m
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import "SamplePlaylistItem.h"

@implementation SamplePlaylistItem

-(instancetype)initWithImage:(UIImage *)image artist:(NSString *)artist song:(NSString *)song {
    self = [super init];
    if (self) {
        _image = image;
        _artist = artist;
        _song = song;
    }
    return self;
}

@end
