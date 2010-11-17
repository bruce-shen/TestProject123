//
//  LauncherViewController.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "LauncherViewController.h"
#import "CorumUINews.h"
#import "CorumUIBlog.h"
#import "CorumUIAbout.h"
#import "CorumExperience.h"
#import "CorumUIEvents.h"
#import "CorumUIVideo.h"
@interface LauncherViewController(Private)

@end
@implementation LauncherViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.navigationBarTintColor = [[UIColor alloc] initWithRed:0.098 green:0.15 blue:0.29 alpha:0.5];
	}
	return self;
}


-(void) viewDidLoad {
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}
#pragma mark -
#pragma mark UIViewController

- (void)loadView {
	[super loadView];

	_launcherView = [[TTLauncherView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	_launcherView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background"]];
	_launcherView.delegate = self;
	_launcherView.columnCount = 3;
	
	_launcherView.pages = [NSArray arrayWithObjects:
						   [NSArray arrayWithObjects:
									 
							[[[TTLauncherItem alloc] initWithTitle:@"News"
															 image:@"bundle://icon_news"
															   URL:@"tt://news/1" canDelete:NO] autorelease],
							
							[[[TTLauncherItem alloc] initWithTitle:@"About"
															 image:@"bundle://icon_about"
															   URL:@"tt://about/1" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Experience"
															 image:@"bundle://icon_experience"
															   URL:@"tt://experience/1" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Blog"
															 image:@"bundle://icon_blog.png"
															   URL:@"tt://blog/1" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Transactions"
															 image:@"bundle://icon_transactions"
															   URL:nil canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Events"
															 image:@"bundle://icon_events"
															   URL:@"tt://events/1" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Videos"
															 image:@"bundle://icon_video"
															   URL:@"tt://video/1" canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Resources"
															 image:@"bundle://icon_resources"
															   URL:nil canDelete:NO] autorelease],
							[[[TTLauncherItem alloc] initWithTitle:@"Valuation"
															 image:@"bundle://icon_valuation"
															   URL:nil canDelete:NO] autorelease],
							nil],nil
						   ];
	[self.view addSubview:_launcherView];
	
	TTLauncherItem* item = [_launcherView itemWithURL:@"tt://video/Video/Blog"];
	NSLog(@"%@",[self.navigationController title]);
	
	item.badgeNumber = 4;
}
#pragma mark -
#pragma mark TTLauncherViewDelegate


- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
//	TTNavigator* navigator = [TTNavigator navigator];
//	[navigator openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
	if ([item.title compare:@"News"] == NSOrderedSame) {
		CorumUINews *news = [[CorumUINews alloc] initWithNibName:@"CorumUINews" bundle:nil];
		[[self navigationController] pushViewController:news animated:YES];
		[news release];
	} else if ([item.title compare:@"About"] == NSOrderedSame) {
		CorumUIAbout *viewController = [[CorumUIAbout alloc] initWithNibName:@"CorumUIAbout" bundle:nil];
		[[self navigationController] pushViewController:viewController animated:YES];
		[viewController release];
	} else if ([item.title compare:@"About"] == NSOrderedSame) {
		CorumUIAbout *viewController = [[CorumUIAbout alloc] initWithNibName:@"CorumUIAbout" bundle:nil];
		[[self navigationController] pushViewController:viewController animated:YES];
		[viewController release];
	}  else if ([item.title compare:@"Experience"] == NSOrderedSame) {
		CorumExperience*viewController = [[CorumExperience alloc] initWithNibName:@"CorumExperience" bundle:nil];
		[[self navigationController] pushViewController:viewController animated:YES];
		[viewController release];
	}  else if ([item.title compare:@"Blog"] == NSOrderedSame) {
		CorumUIBlog *viewController = [[CorumUIBlog alloc] initWithNibName:@"CorumUIBlog" bundle:nil];
		[[self navigationController] pushViewController:viewController animated:YES];
		[viewController release];
	}  else if ([item.title compare:@"Events"] == NSOrderedSame) {
		CorumUIEvents *viewController = [[CorumUIEvents alloc] initWithNibName:@"CorumUIEvents" bundle:nil];
		[[self navigationController] pushViewController:viewController animated:YES];
		[viewController release];
	}  else if ([item.title compare:@"Videos"] == NSOrderedSame) {
		CorumUIVideo *viewController = [[CorumUIVideo alloc] initWithNibName:@"CorumUIVideo" bundle:nil];
		[[self navigationController] pushViewController:viewController animated:YES];
		[viewController release];
	}
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}
- (void)dealloc {
	[super dealloc];
}
@end
