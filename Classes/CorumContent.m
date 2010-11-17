//
//  CorumContent.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/17/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "CorumContent.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface CorumContent(Private)

@end

@implementation CorumContent
@synthesize timeLabel,authorLabel,titleLabel,textViewBody;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		textViewBody.backgroundColor = [UIColor clearColor];
		textViewBody.font = [UIFont fontWithName:@"Helvetica" size:14];
		
	}
	return self;
}
-(void) viewWillAppear:(BOOL)animated {

	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyBackground"]];
}
-(void) viewDidLoad {
	
}
-(void) dealloc {
	[timeLabel release];
	[authorLabel release];
	[titleLabel release];
	[textViewBody release];
	[super dealloc];
}
@end

