//
//  ChecklistItem.m
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

@synthesize text, isChecked;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeBool:self.isChecked forKey:@"isChecked"];
}

-(void) toggleChecked
{
    self.isChecked = !self.isChecked;
}

@end
