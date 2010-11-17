//
//  DataFetcher.h
//  CorumThree20
//
//  Created by Zitao Xiong on 11/15/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataFetcher : NSObject {
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
-(void) fetchNewBlogs;
@end
