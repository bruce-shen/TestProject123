//
//  CorumNews.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/17/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "CorumNews.h"
#import "CMTableViewDataSource.h"
#import "CMTableItem.h"
@implementation CorumNews
-(id) init {
	if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = @"News";
		self.variableHeightRows = YES;
		datasource = [[CMTableViewDataSource alloc] initWithEntityName:@"News"];
		datasource.fetchedResultsController.delegate = self;
		datasource.url = @"tt://launcherView";
		datasource.tableItemDelegate = self;
		fetchedResultsController_ = datasource.fetchedResultsController;
		[datasource initItemsBelowBatchedSize];
		
		self.dataSource = datasource;
		self.showTableShadows = YES;
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(insertNewObject)] autorelease];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(popNaviationView)];
	}
	return self;
}
-(void)popNaviationView{
	[self.navigationController popViewControllerAnimated:YES];
}
-(TTTableItem*) configureTableItemAtIndexPath:(NSIndexPath*)indexPath FetchedResultsController:(NSFetchedResultsController*) fetchedResultsController{
	NSLog(@"configure");
	NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
	NSString *url = [NSString stringWithFormat:@"tt://news/content/%d",indexPath.row
					 ];
	NSLog(@"%@",url);
	CMTableItem *item = [CMTableItem itemWithTitle:[[managedObject valueForKey:@"title"] description]  caption:[managedObject valueForKey:@"author"] text:[managedObject valueForKey:@"body"] timestamp:[NSDate date] URL:@"3"];

	return item;
}
-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *managedObject = [fetchedResultsController_ objectAtIndexPath:indexPath];
	NSArray *arr = [NSArray arrayWithObjects:[managedObject valueForKey:@"title"],
					[managedObject valueForKey:@"body"],
					[managedObject valueForKey:@"author"],
					nil];
	//TTURLAction *urlAction = [TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://news/content/%d",indexPath.row]];
	TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://news/content/news"];
	[urlAction applyQuery:[NSDictionary dictionaryWithObject:arr forKey:@"contentkey"]];
	[urlAction applyAnimated:YES];
	[[TTNavigator navigator] openURLAction:urlAction];
	//Pass all data to content
	//Pass index and fetchedResultsController to content
}
@end
