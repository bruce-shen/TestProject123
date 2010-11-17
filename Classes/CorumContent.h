//
//  CorumContent.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/17/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

@interface CorumContent : UIViewController {

	IBOutlet UILabel *timeLabel;
	IBOutlet UILabel *authorLabel;
	IBOutlet UILabel *titleLabel;
	IBOutlet UITextView *textViewBody;

}
@property(nonatomic,retain) UILabel *timeLabel;
@property(nonatomic,retain) UILabel *authorLabel;
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,assign) UITextView *textViewBody;
@end
