//
//  ChecklistItem.h
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

// description of checklist item
@property (nonatomic, copy) NSString *text;

// determines if a cell is checked or not
@property (nonatomic, assign) BOOL isChecked;

@end
