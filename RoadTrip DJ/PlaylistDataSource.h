//
//  PlaylistDataSource.h
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistItem.h"

@interface PlaylistDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger currentTrackIndex;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *items;

@end
