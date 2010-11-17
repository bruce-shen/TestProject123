//
//  CorumStyle.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/27/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "CorumStyle.h"


@implementation CorumStyle

- (TTStyle*)launcherButton:(UIControlState)state {
	return
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE(launcherButtonImage:, state) next:
	 [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:14] color:RGBCOLOR(255, 255, 255)
				minimumFontSize:15 shadowColor:nil
				   shadowOffset:CGSizeZero next:nil]];
}
- (UIColor*)navigationBarTintColor {
	return RGBCOLOR(119, 140, 168);
}
- (int)myTitle {
	return 1;
}
@end
