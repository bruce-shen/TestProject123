//
//  CorumThree20AppDelegate.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright Cosmo 2010. All rights reserved.
//


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "LauncherViewController.h"
#import "TableItemController.h"
#import "CMTableViewController.h"
#import "CorumBlog.h"
#import "CorumNews.h"
#import "CorumEvents.h"
#import "CorumAbout.h"
#import "CorumResources.h"
#import "CorumVideos.h"
#import "CorumContent.h"
@interface AppDelegate : NSObject <UIApplicationDelegate> {
  NSManagedObjectContext*       _managedObjectContext;

  // App State
  BOOL                          _modelCreated;
  BOOL                          _resetModel;
}


@property (nonatomic, readonly)         NSString*               applicationDocumentsDirectory;


@end

