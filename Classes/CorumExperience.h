//
//  CorumExperience.h
//  Corum
//
//  Created by Zitao Xiong on 9/25/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionPageViewController.h"

@interface CorumExperience : UIViewController <NSFetchedResultsControllerDelegate,UIScrollViewDelegate>  {
	//for summary
	IBOutlet UIView *summaryView;
	IBOutlet UITextView *myTextView;
	IBOutlet UIBarButtonItem *summaryViewButton1;
	IBOutlet UIBarButtonItem *transactionViewButton1;

	//for transaction
	IBOutlet UIView *transactionView;
	IBOutlet UIBarButtonItem *summaryViewButton2;
	IBOutlet UIBarButtonItem *transactionViewButton2;
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	NSMutableArray *viewControllers;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}
-(IBAction) clickSummaryView;
-(IBAction) clickTransactionView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UITextView *myTextView;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
-(IBAction) changePage:(id)sender;
@end
