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

@interface ChecklistViewController : UITableViewController <ItemDetailControllerDelegate>

// no longer needed (fake add item method)
//-(IBAction)addItem;

@end
