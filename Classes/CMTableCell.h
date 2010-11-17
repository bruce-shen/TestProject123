//
//  CMTableCell.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/30/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "Three20UI/TTTableLinkedItemCell.h"

@class TTImageView;

@interface CMTableCell : TTTableLinkedItemCell {
	UILabel*      _titleLabel;
	UILabel*      _timestampLabel;
	TTImageView*  _imageView2;
}

@property (nonatomic, readonly, retain) UILabel*      titleLabel;
@property (nonatomic, readonly)         UILabel*      captionLabel;
@property (nonatomic, readonly, retain) UILabel*      timestampLabel;
@property (nonatomic, readonly, retain) TTImageView*  imageView2;

@end
