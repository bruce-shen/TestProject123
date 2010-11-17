//
//  TransactionPageViewController.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/31/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "TransactionPageViewController.h"


@implementation TransactionPageViewController

-(id) initWithPageNumber:(int)page {
	if (self = [super initWithNibName:@"TransactionPageViewController" bundle:nil]) {
		pageNumber = page;
		self.view.backgroundColor = [UIColor clearColor];
	}
	return self;
}
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
    [super dealloc];
}


@end
