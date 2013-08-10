//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
// import needed for the delegate
#import "ItemDetailViewController.h"
// import needed to show the correct title
#import "Checklist.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;
// no longer needed (fake add item method)
//-(IBAction)addItem;

@end
