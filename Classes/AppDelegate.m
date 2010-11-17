//
//  CorumThree20AppDelegate.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright Cosmo 2010. All rights reserved.
//

#import "AppDelegate.h"
#import "CorumStyle.h"
#import "CorumUINews.h"
#import "CorumUIBlog.h"
#import "CorumUIVideo.h"
#import "CorumUIAbout.h"
#import "CorumUIEvents.h"
#import "CorumExperience.h"

#define kStoreType      NSSQLiteStoreType
#define kStoreFilename  @"db.sqlite"
#define Debug


@implementation AppDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application {
 
	
  TTNavigator* navigator = [TTNavigator navigator];
  navigator.persistenceMode = TTNavigatorPersistenceModeAll;

  TTURLMap* map = navigator.URLMap;

	//[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"tt://launcherView" toViewController:[LauncherViewController class]];
	[map from:@"tt://experience/(init)" toViewController:[CorumExperience class]];
	//[map from:@"tt://news/(init:)" toViewController:[CorumNews class]];
	[map from:@"tt://news/(init:)" toViewController:[CorumUINews class]];
	[map from:@"tt://events/(init:)" toViewController:[CorumUIEvents class]];
	[map from:@"tt://about/(init:)" toViewController:[CorumUIAbout class]];
	[map from:@"tt://resources/(initWithTitle:)/(entityName:)" toViewController:[CorumResources class]];
	[map from:@"tt://blog/(init:)" toViewController:[CorumUIBlog class]];
	[map from:@"tt://video/(init:)" toViewController:[CorumUIVideo class]];
	[map from:@"tt://tableview/(initWithTitle:)/(entityName:)" toViewController:[CMTableViewController class]];
	[map from:@"tt://play/(playVideo:)" toViewController:[CorumVideos class]];
	[map from:@"tt://news/content/(initWithName:)" toViewController:[CorumContent class]];
#ifdef Debug
		[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://launcherView"]];
#else
	if (![navigator restoreViewControllers]) {
		[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://launcherView"]];
	}
#endif
	CorumStyle *style = [[CorumStyle alloc] init];
	[TTStyleSheet setGlobalStyleSheet:style];
	[style release];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_managedObjectContext);

	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillTerminate:(UIApplication *)application {
  NSError* error = nil;
  if (_managedObjectContext != nil) {
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)applicationDocumentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
    lastObject];
}


@end

