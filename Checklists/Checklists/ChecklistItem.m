//
//  ChecklistItem.m
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

@synthesize text, isChecked, dueDate, shouldRemind, itemId;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init]))
    {
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.isChecked = [aDecoder decodeBoolForKey:@"isChecked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntForKey:@"ItemID"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeBool:self.isChecked forKey:@"isChecked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemID"];
}

-(id)init
{
    if(self = [super init])
    {
        // calling the method responsible to give an ID to the checklist item
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

-(void) toggleChecked
{
    self.isChecked = !self.isChecked;
}

@end
