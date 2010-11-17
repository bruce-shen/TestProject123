//
//  BlogObject.m
//  CorumThree20
//
//  Created by Zitao Xiong on 10/31/10.
//  Copyright 2010 Cosmo. All rights reserved.
//

#import "BlogObject.h"


@implementation BlogObject
- (NSString *)author 
{
    NSString * tmpValue;
    
    [self willAccessValueForKey:@"author"];
    tmpValue = [self primitiveValueForKey:@"author"];
    [self didAccessValueForKey:@"author"];
    
    return tmpValue;
}

- (void)setAuthor:(NSString *)value 
{
    [self willChangeValueForKey:@"author"];
    [self setPrimitiveValue:value forKey:@"author"];
    [self didChangeValueForKey:@"author"];
}

- (BOOL)validateAuthor:(id *)valueRef error:(NSError **)outError 
{
    // Insert custom validation logic here.
    return YES;
}

- (NSString *)body 
{
    NSString * tmpValue;
    
    [self willAccessValueForKey:@"body"];
    tmpValue = [self primitiveValueForKey:@"body"];
    [self didAccessValueForKey:@"body"];
    
    return tmpValue;
}

- (void)setBody:(NSString *)value 
{
    [self willChangeValueForKey:@"body"];
    [self setPrimitiveValue:value forKey:@"body"];
    [self didChangeValueForKey:@"body"];
}

- (BOOL)validateBody:(id *)valueRef error:(NSError **)outError 
{
    // Insert custom validation logic here.
    return YES;
}

- (NSNumber *)isRead 
{
    NSNumber * tmpValue;
    
    [self willAccessValueForKey:@"isRead"];
    tmpValue = [self primitiveValueForKey:@"isRead"];
    [self didAccessValueForKey:@"isRead"];
    
    return tmpValue;
}

- (void)setIsRead:(NSNumber *)value 
{
    [self willChangeValueForKey:@"isRead"];
    [self setPrimitiveValue:value forKey:@"isRead"];
    [self didChangeValueForKey:@"isRead"];
}

- (BOOL)validateIsRead:(id *)valueRef error:(NSError **)outError 
{
    // Insert custom validation logic here.
    return YES;
}

- (NSDate *)timeStamp 
{
    NSDate * tmpValue;
    
    [self willAccessValueForKey:@"timeStamp"];
    tmpValue = [self primitiveValueForKey:@"timeStamp"];
    [self didAccessValueForKey:@"timeStamp"];
    
    return tmpValue;
}

- (void)setTimeStamp:(NSDate *)value 
{
    [self willChangeValueForKey:@"timeStamp"];
    [self setPrimitiveValue:value forKey:@"timeStamp"];
    [self didChangeValueForKey:@"timeStamp"];
}

- (BOOL)validateTimeStamp:(id *)valueRef error:(NSError **)outError 
{
    // Insert custom validation logic here.
    return YES;
}

- (NSString *)title 
{
    NSString * tmpValue;
    
    [self willAccessValueForKey:@"title"];
    tmpValue = [self primitiveValueForKey:@"title"];
    [self didAccessValueForKey:@"title"];
    
    return tmpValue;
}

- (void)setTitle:(NSString *)value 
{
    [self willChangeValueForKey:@"title"];
    [self setPrimitiveValue:value forKey:@"title"];
    [self didChangeValueForKey:@"title"];
}

- (BOOL)validateTitle:(id *)valueRef error:(NSError **)outError 
{
    // Insert custom validation logic here.
    return YES;
}


@end
