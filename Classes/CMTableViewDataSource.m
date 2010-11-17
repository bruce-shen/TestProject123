//
//  CMTableViewDataSource.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright 2010 Cosmo. All rights reserved.
//  
//

#import "CMTableViewDataSource.h"
#import "CMCoreData.h"
#import "CMTableCell.h"
#import "CMTableItem.h"

@implementation CMTableViewDataSource

@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;
@synthesize url = url_;
@synthesize tableItemDelegate = tableItemDelegate_;
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
	
	if ([object isKindOfClass:[CMTableItem class]]) { 
		return [CMTableCell class]; 	
	}  else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}


-(id) initWithEntityName:(NSString *)entityName {
	return [self initWithManagedObjectContext:[[CMCoreData sharedInstance] managedObjectContext] entityName:entityName fetchBatchSize:20 sortDescriptorKey:@"timeStamp"];
}


-(id) initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext entityName:(NSString*)entityName fetchBatchSize:(int) fetchBatchSize sortDescriptorKey:(NSString*) sortDescriptorKey {
	if (self = [self init]) {
		managedObjectContext_ = managedObjectContext;
		entityName_ = entityName;
		fetchBatchSize_ = fetchBatchSize;
		sortDescriptorKey_ = sortDescriptorKey;
		_items = [[NSArray array] mutableCopy];
	}
	return self;
}

#pragma mark -
#pragma mark Customize Object Method

- (void)initItemsBelowBatchedSize{
	NSUInteger max = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
	NSLog(@"max: %d",max);
	for (NSUInteger i = 0; i < max; i++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
		TTTableItem *item;
		if (tableItemDelegate_!=nil) {
			item = [tableItemDelegate_ configureTableItemAtIndexPath:indexPath FetchedResultsController:fetchedResultsController_];
		} else {
			NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
			item = [TTTableMessageItem itemWithTitle:[[managedObject valueForKey:@"title"] description]  caption:@"caption" text:@"text" timestamp:[NSDate date] URL:url_];
		}

		[_items addObject:item];
	}

}
#pragma mark -
#pragma mark Add a new object
// for test purpose
- (void)insertNewObject {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    [newManagedObject setValue:@"Cosmo" forKey:@"author"];
	[newManagedObject setValue:@"Beautiful Day" forKey:@"title"];
	[newManagedObject setValue:@"This is a beautiful day" forKey:@"body"];
    
	// Insert item into current items, this has to be done before save to database
	TTTableMessageItem *item = [TTTableMessageItem itemWithTitle:@"new" caption:@"caption" text:@"text" timestamp:[NSDate date] URL:@"tt://tableView"];
	[_items addObject:item];
	
	// Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
	NSLog(@"insert new object");

	
}

#pragma mark -
#pragma mark Overwrite TTListDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
	if (indexPath.row < _items.count) {
		return [_items objectAtIndex:indexPath.row];
	} else {
		return nil;
	}
}
#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName_ inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:fetchBatchSize_];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortDescriptorKey_ ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
	

    
	
	self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}    

-(void) dealloc {
	TT_RELEASE_SAFELY(_items);
	TT_RELEASE_SAFELY(entityName_);
	TT_RELEASE_SAFELY(sortDescriptorKey_);
	TT_RELEASE_SAFELY(fetchedResultsController_);
	[super dealloc];
}
@end
