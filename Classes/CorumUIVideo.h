//
//  CorumUINews.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/30/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CorumContent.h"
#define	TOP_LABEL_TAG  1001
#define	BOTTOM_LABEL_TAG  1002
#define	STAR_TAG  1003
@interface CorumUIVideo : UITableViewController <NSFetchedResultsControllerDelegate> {
	MPMoviePlayerController *player;
	UITableView *tableView_;
	
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
