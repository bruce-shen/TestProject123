//
//  
//  Corum
//
//  Created by Zitao Xiong on 9/25/10.
//  Copyright 2010 Cosmo. All rights reserved.
//


#import "CorumUIVideo.h"
#import "CMCoreData.h"
#import "VideoObject.h"

@implementation CorumUIVideo
@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;
@synthesize tableView=tableView_;

#pragma mark -
#pragma mark init
- (id)init {
    if ((self = [super initWithNibName:@"CorumUIVideo" bundle:nil])) {
		self.managedObjectContext = [[CMCoreData sharedInstance] managedObjectContext];
		
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.managedObjectContext = [[CMCoreData sharedInstance] managedObjectContext];
    }
    return self;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	UILabel *bottomLabel = (UILabel*) [cell viewWithTag:BOTTOM_LABEL_TAG];
	bottomLabel.textColor = [UIColor colorWithRed:0.359 green:0.359 blue:0.359 alpha:1.0];
	UIView *starView = [cell viewWithTag:STAR_TAG];
	[starView removeFromSuperview];
}

#pragma mark -
#pragma mark Video Play Controll
- (void)playVideoWithURL:(NSURL *) url showControls:(BOOL) showControls {
	if (!player) {
		player = [[MPMoviePlayerController alloc] initWithContentURL:url];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
		[self.navigationController setNavigationBarHidden:YES animated:YES];
		//[player setFullscreen:YES animated:YES];
		player.controlStyle = MPMovieControlStyleFullscreen;
		[player.view setTag:1006];
		[[player view] setFrame:CGRectMake(0, 0, 320, 480)];
		[self.view addSubview:[player view]];
		[player play];
	}
}
- (void)didFinishPlaying:(NSNotification *)notification {
	if (player == [notification object]) {	
		[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
		[[self.view viewWithTag:1006] removeFromSuperview];
		[[UIApplication sharedApplication] setStatusBarHidden:NO];
		[self.navigationController setNavigationBarHidden:NO animated:YES];
		[player release];
		player = nil;
	}
}

#pragma mark -
#pragma mark CustomizeTable
- (void)viewDidLoad
{
	self.title = @"Video";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self.navigationController action:@selector(popViewControllerAnimated:)] autorelease];
    //
    // Change the properties of the imageView and tableView (these could be set
    // in interface builder instead).
    //
    tableView_.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView_.rowHeight = 60;
	tableView_.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(insertNewObject)] autorelease];
	
}

#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
	[newManagedObject setValue:@"Beautiful Day" forKey:@"title"];
	[newManagedObject setValue:@"corum.mov" forKey:@"videourl"];
	[newManagedObject setValue:[NSNumber numberWithBool:NO]	forKey:@"isRead"];
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
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	UILabel *topLabel;
	UILabel *bottomLabel;
	
	
    UITableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 300, 100) reuseIdentifier:CellIdentifier] autorelease];
		UIImage *background = [UIImage imageNamed:@"TableCell"];
		cell.backgroundView = [[[UIImageView alloc] initWithImage:background] autorelease];
		topLabel = [[[UILabel alloc] initWithFrame:CGRectMake(80, 10, 250, 20)] autorelease];
		[cell.contentView addSubview:topLabel];
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		
		topLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:14];
		//
		// Create the label for the top row of text
		//
		bottomLabel = [[[UILabel alloc] initWithFrame:CGRectMake(80,30,250,20)] autorelease];
		[cell.contentView addSubview:bottomLabel];
		
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.359 green:0.359 blue:0.359 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
		//
		// Create video image view
		//
		UIImageView *videoImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 8, 70, 40)];
		[videoImage setImage:[UIImage imageNamed:@"videoDefaultThumb"]];
		[cell.contentView addSubview:videoImage];
		[videoImage release];
		

    } else {
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
	
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	topLabel.text = [[managedObject valueForKey:@"title"] description];
	//
	//Set Date Formate
	//
	NSDate *date = [managedObject valueForKey:@"timeStamp"];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd MMM yyyy"];
	bottomLabel.text = [NSString stringWithFormat:@"Date: %@",[dateFormatter stringFromDate:date]];
	[dateFormatter release];
	//
	//Set Color if cell not read
	//
	
	if (![[managedObject valueForKey:@"isRead"] boolValue]) {
		bottomLabel.textColor = [UIColor colorWithRed:0.106 green:0.325 blue:0.467 alpha:1.0];
		UIImage *star = [UIImage imageNamed:@"Star"];
		UIImageView *starView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		[starView setImage:star];
		[starView setTag:STAR_TAG];
		[cell.contentView addSubview:starView];
		[starView release];
	}
	
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
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
    }   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	VideoObject *selectedObject =  (VideoObject*)[[self fetchedResultsController] objectAtIndexPath:indexPath];
	[selectedObject setIsRead:[NSNumber numberWithBool:YES]];
	NSError *error = nil;
	
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
	}
	NSLog(@"%@",[selectedObject videourl]);
	NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"corum" ofType:@"mov"];
	NSURL *url = [NSURL fileURLWithPath:videoPath];
	[self playVideoWithURL:url showControls:YES];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Videos" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
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


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
			[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tableView_ release];
	[fetchedResultsController_ release];
    [managedObjectContext_ release];
    [super dealloc];
}


@end
