//
//  NSMutableArray+QueueMethods.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "NSMutableArray+QueueMethods.h"

@implementation NSMutableArray (QueueMethods)

- (void)pushObject:(id)object
{
    [self addObject:object];
}

- (id)popObject
{
    if (self.count > 0) {
        id object = self[0];
        [self removeObjectAtIndex:0];
        return object;
    }
    
    return nil;
}

- (id)topObject
{
    if (self.count > 0) {
        return self[0];
    }
    
    return nil;
}


@end
