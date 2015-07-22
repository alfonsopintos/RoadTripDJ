//
//  PlayerBar.h
//  RoadTrip DJ
//
//  Created by Alfonso Pintos on 7/21/15.
//  Copyright © 2015 Meme Menu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayerBarDelegate;

IB_DESIGNABLE
@interface PlayerBar : UIToolbar

@property (nonatomic, weak) IBOutlet id<PlayerBarDelegate> playerBarDelegate;

@property (nonatomic, assign) IBInspectable CGFloat spacing;

@end


@protocol PlayerBarDelegate <NSObject>

-(void)playerBarPreviousTrack:(PlayerBar *)playerBar;
-(void)playerBarNextTrack:(PlayerBar *)playerBar;
-(void)playerBarPlayPause:(PlayerBar *)playerBar;

@end