//
//  Checklist.m
//  Checklists
//
//  Created by João Carreira on 8/9/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "Checklist.h"

@implementation Checklist

@synthesize name, items;

-(id)init
{
    if((self = [super init]))
    {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}

@end
