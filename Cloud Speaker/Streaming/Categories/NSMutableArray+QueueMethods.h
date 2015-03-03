//
//  NSMutableArray+QueueMethods.h
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueMethods)

- (void)pushObject:(id)object;
- (id)popObject;
- (id)topObject;

@end
