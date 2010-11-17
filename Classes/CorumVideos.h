//
//  CorumVideos.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/17/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMTableViewController.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MediaPlayer.h>
@interface CorumVideos : CMTableViewController {
	MPMoviePlayerViewController *player;
}
@property (nonatomic, retain) MPMoviePlayerViewController *player;


- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;
- (void)playVideo:(NSString*) url;
@end
