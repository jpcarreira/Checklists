//
//  Checklist.h
//  Checklists
//
//  Created by João Carreira on 8/9/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSMutableArray *items;

// checklist icon name
@property (nonatomic, copy) NSString *iconName;

-(int)countUncheckedItems;

@end
