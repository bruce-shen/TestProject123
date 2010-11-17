//
//  VideoObject.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/31/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VideoObject : NSManagedObject {

}
- (NSNumber *)isRead;
- (void)setIsRead:(NSNumber *)value;
- (BOOL)validateIsRead:(id *)valueRef error:(NSError **)outError;

- (NSDate *)timeStamp;
- (void)setTimeStamp:(NSDate *)value;
- (BOOL)validateTimeStamp:(id *)valueRef error:(NSError **)outError;

- (NSString *)title;
- (void)setTitle:(NSString *)value;
- (BOOL)validateTitle:(id *)valueRef error:(NSError **)outError;

- (NSString *)videourl;
- (void)setVideourl:(NSString *)value;
- (BOOL)validateVideourl:(id *)valueRef error:(NSError **)outError;


@end
