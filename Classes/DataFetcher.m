//
//  DataFetcher.m
//  CorumThree20
//
//  Created by Zitao Xiong on 11/15/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "DataFetcher.h"
#import "ASIHTTPRequest.h"
#import "TouchXML.h"
#import "CMCoreData.h"
@interface DataFetcher(Private) 
- (void) insertBlogPost:(NSString*) title author:(NSString*) author body:(NSString*) body timeStamp:(NSString*) dateString isRead:(Boolean) isRead;
@end
@implementation DataFetcher
@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;
-(id) init {
	if ((self = [super init])) {
		self.managedObjectContext = [[CMCoreData sharedInstance] managedObjectContext];
	}
	return self;
}
-(void) fetchNewBlogs {
	NSURL *url = [NSURL URLWithString:@"http://192.168.1.140:8080/CorumiPhone/blogService.asmx/getRecentBlogsData"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"Call Back");
	NSString *xmlData = [request responseString];
	CXMLDocument *doc = [[[CXMLDocument alloc] initWithXMLString:xmlData options:0 error:nil] autorelease];
	NSArray *nodes = NULL;
	nodes = [doc nodesForXPath:@"//Table" error:nil];
	for (CXMLElement *node in nodes) {
		NSString* dateString = [[[node elementsForName:@"PostDate"] objectAtIndex:0] stringValue];
		NSString* title = [[[node elementsForName:@"title"] objectAtIndex:0] stringValue];
		NSString* author = [[[node elementsForName:@"name"] objectAtIndex:0] stringValue];
		NSString* body = [[[node elementsForName:@"body"] objectAtIndex:0] stringValue];
		[self insertBlogPost:title author:author body:body timeStamp:dateString isRead:NO];
	}
}
- (void) insertBlogPost:(NSString*) title author:(NSString*) author body:(NSString*) body timeStamp:(NSString*) dateString isRead:(Boolean) isRead{
	//convert the dateString to NSDate, I didn't found -05:00 's time zone represent String
	//So hard code here for now
	NSDateFormatter *formater = [[[NSDateFormatter alloc] init] autorelease];
	[formater setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS-'05:00'"];
	NSDate *date = [formater dateFromString:dateString];
	
	//Compare the date with newest post in Database

	

	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"News" inManagedObjectContext:[self managedObjectContext]];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	// Set example predicate and sort orderings...
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(title = %@) AND (author = %@)", title,author];
	[request setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"timeStamp" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error;
	NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
	if (array != nil && [array count]!=0)
	{
		//means there is object in sql database
	}else {
		NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
		NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
		
		// If appropriate, configure the new managed object.
		[newManagedObject setValue:date forKey:@"timeStamp"];
		[newManagedObject setValue:author forKey:@"author"];
		[newManagedObject setValue:title forKey:@"title"];
		[newManagedObject setValue:body forKey:@"body"];
		[newManagedObject setValue:[NSNumber numberWithBool:isRead]	forKey:@"isRead"];
		// Save the context.
		NSError *error = nil;
		if (![context save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		
	}


	
}
- (void)requestFailed:(ASIHTTPRequest *)request{
	
}
@end
