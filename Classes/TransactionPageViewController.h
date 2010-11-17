//
//  TransactionPageViewController.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/31/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TransactionPageViewController : UIViewController {
	int pageNumber;
}
-(id)initWithPageNumber:(int)page;
@end
