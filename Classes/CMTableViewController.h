//
//  CMTableViewController.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/11/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "CMTableViewDataSource.h"
//TTTableViewController is a subclass of TTModelViewController, hence, it inherits a 'model' property. But since you are using a TTTableViewController, you do *not* need to set the 'model' property. Instead, just set the 'dataSource' property, and the TTTableViewController machinery will automatically set the 'model' property for you based on the 'model' that your <TTTableViewDataSource> was configured for.
//

@interface CMTableViewController : TTTableViewController<NSFetchedResultsControllerDelegate> {
	CMTableViewDataSource *datasource;
}

-(id) initWithTitle:(NSString *) title entityName:(NSString *) entityName;

@end


