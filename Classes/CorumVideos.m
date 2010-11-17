//
//  CorumVideos.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/17/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "CorumVideos.h"


@implementation CorumVideos
@synthesize player;

-(id) initWithTitle:(NSString *) title entityName:(NSString *) entityName {
	return [super initWithTitle:title entityName:entityName];
}

#pragma mark -
#pragma mark Video Play Controll
- (void)playVideoWithURL:(NSURL *) url showControls:(BOOL) showControls {
	if (!player) {
		//player = [[MPMoviePlayerController alloc] initWithContentURL:url];
		player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:player.moviePlayer];
		if (!showControls) {
			player.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
			player.moviePlayer.controlStyle = MPMovieControlStyleNone;
		}
		[self.navigationController setNavigationBarHidden:YES animated:YES];
		[self.view insertSubview:player.view atIndex:1];
		[player.moviePlayer play];
	}
}
- (void)didFinishPlaying:(NSNotification *)notification {
	if (player.moviePlayer == [notification object]) {	
		[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player.moviePlayer];
		[player.moviePlayer release];
		player = nil;
	}
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[[[self.view subviews] objectAtIndex:1] removeFromSuperview];
}

- (void)playVideo:(NSString*) url{
	NSLog(@"Video:%@",url);
	NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"corum" ofType:@"mov"];
	NSURL *url2 = [NSURL fileURLWithPath:videoPath];
	[self playVideoWithURL:url2 showControls:YES];
}


- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	NSLog(@"did hello");
	NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"corum" ofType:@"mov"];
	NSURL *url = [NSURL fileURLWithPath:videoPath];
	[self playVideoWithURL:url showControls:YES];
}

@end
