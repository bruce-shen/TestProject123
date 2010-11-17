//
//  CMTableViewDataSource.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright 2010 Cosmo. All rights reserved.
//  Set the entityName then use it.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
@protocol CMTableItemConfigure
@required
-(TTTableItem*) configureTableItemAtIndexPath:(NSIndexPath*)indexPath FetchedResultsController:(NSFetchedResultsController*) fetchedResultsController;
@end
@interface CMTableViewDataSource : TTListDataSource <NSFetchedResultsControllerDelegate>{

@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	id<CMTableItemConfigure> tableItemDelegate_;
	NSString *entityName_;
	NSUInteger fetchBatchSize_;
	NSString *sortDescriptorKey_;
	NSString *url_;
}

@property (nonatomic, retain) id<CMTableItemConfigure> tableItemDelegate;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSString *url;
-(id) initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext entityName:(NSString*)entityName fetchBatchSize:(int) fetchBatchSize sortDescriptorKey:(NSString*) sortDescriptor;
-(id) initWithEntityName:(NSString *)entityName ;

- (void)initItemsBelowBatchedSize;
- (void)insertNewObject;
@end
