//
//  Checklist.m
//  Checklists
//
//  Created by João Carreira on 8/9/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

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

/**
 * counts the total of unchecked items in a checklist
 */
-(int)countUncheckedItems
{
    int count = 0;
    for(ChecklistItem *item in self.items)
    {
        if(!item.isChecked)
        {
            count++;
        }
    }
    return count;
}

#pragma mark - NSCoder
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init]))
    {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}

/**
 * comparison method (needed for sort in DataModel) based
 * on checklist's name
 */
-(NSComparisonResult)compare:(Checklist *)otherChecklist
{
    // the invoked method is not case sensitive
    return [self.name localizedStandardCompare:otherChecklist.name];
}

@end
