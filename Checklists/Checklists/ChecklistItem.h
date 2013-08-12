//
//  ChecklistItem.h
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSCoding needed for serialization
@interface ChecklistItem : NSObject <NSCoding>

// description of checklist item
@property (nonatomic, copy) NSString *text;
/* COPY: When you want to hold onto a copy of some value instead of the value itself. For example, 
 if you want to hold onto an array and don’t want people to be able to change its contents after they set it. 
 This sends a copy message to the value passed in, then keeps that. */

// determines if a cell is checked or not
@property (nonatomic, assign) BOOL isChecked;
/* ASSIGN: When you’re dealing with basic types, like ints, floats, etc. The compiler just creates a setter with 
 a simple myField = value statement. This is the default, but not usually what you want. */

-(void) toggleChecked;

@end
