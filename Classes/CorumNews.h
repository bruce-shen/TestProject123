//
//  CorumNews.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/17/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMTableViewController.h"

@interface CorumNews : CMTableViewController<CMTableItemConfigure> {
	NSFetchedResultsController *fetchedResultsController_;
}

-(TTTableItem*) configureTableItemAtIndexPath:(NSIndexPath*)indexPath FetchedResultsController:(NSFetchedResultsController*) fetchedResultsController;
@end
