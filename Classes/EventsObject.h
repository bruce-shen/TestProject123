//
//  EventsObject.h
//  CorumThree20
//
//  Created by Zitao Xiong on 10/31/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventsObject : NSManagedObject {

}
- (NSString *)body;
- (void)setBody:(NSString *)value;
- (BOOL)validateBody:(id *)valueRef error:(NSError **)outError;

- (NSString *)title;
- (void)setTitle:(NSString *)value;
- (BOOL)validateTitle:(id *)valueRef error:(NSError **)outError;

- (NSDate *)timeStamp;
- (void)setTimeStamp:(NSDate *)value;
- (BOOL)validateTimeStamp:(id *)valueRef error:(NSError **)outError;


@end
