//
//  AddItemViewController.h
//  Checklists
//
//  Created by João Carreira on 8/4/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;

-(IBAction)cancel;
-(IBAction)done;

@end
