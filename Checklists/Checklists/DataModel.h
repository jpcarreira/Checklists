//
//  DataModel.h
//  Checklists
//
//  Created by João on 8/11/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

-(void)saveChecklists;
-(int)getIndexOfSelectedChecklist;
-(void)setIndexOfSelectedChecklist:(int)index;

@end
