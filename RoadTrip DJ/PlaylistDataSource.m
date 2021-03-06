//
//  PlaylistDataSource.m
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import "PlaylistDataSource.h"
#import "PlaylistItemCollectionViewCell.h"
#import "PlaylistHeaderView.h"

@implementation PlaylistDataSource

-(void)setItems:(NSArray *)items {
    _items = items;
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

-(nonnull UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PlaylistItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    id<PlaylistItem> playlistItem = self.items[indexPath.row];
    cell.imageView.image = playlistItem.image;
    cell.artistLabel.text = playlistItem.artist;
    cell.songLabel.text = playlistItem.song;

    return cell;
}

- (UICollectionReusableView *)collectionView:(nonnull UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PlaylistHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                        withReuseIdentifier:@"header"
                                                                               forIndexPath:indexPath];
        [header setPlaylistItem:self.items[0] animated:YES];
        return header;
    } else {
        return nil;
    }
}

@end
