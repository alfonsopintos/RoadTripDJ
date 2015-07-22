//
//  PlaylistItem.h
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaylistItem <NSObject>

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *song;

@end
