//
//  CMTableViewDelegate.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CMTableViewDelegate : <NSFetchedResultsControllerDelegate> {
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end
