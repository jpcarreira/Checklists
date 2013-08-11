//
//  AllListsViewController.h
//  Checklists
//
//  Created by João Carreira on 8/9/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;
// before using DataModel class
//-(void)saveChecklists;

@end
