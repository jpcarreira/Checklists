//
//  ItemDetailViewController.h
//  Checklists
//
//  Created by João Carreira on 8/4/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"

/* defining a custom delegate so that itemDetailViewController can
 communicate back to to CheckListItemViewController; the 
 delegate also needs the property shown after @interface */
@class ItemDetailViewController;
@class ChecklistItem;
@protocol ItemDetailControllerDelegate <NSObject>
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *) controller;
-(void)itemDetailViewController:(ItemDetailViewController *) controller didFinishAddingItem:(ChecklistItem *) item;
-(void)itemDetailViewController:(ItemDetailViewController *) controller didFinishEdititingItem:(ChecklistItem *) item;
@end

/* added UITextFieldDelegate to make the ViewController a delegate of the TextField: 
 this allows the view controller to check whether there's text, 
 or not, in the textfield */
/* DatePickerViewController makes this viewcontroller also a delegate of DatePickerViewController */
@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate, DatePickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, strong) ChecklistItem *itemToEdit;

// properties relating due date of the checklistitem
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;

@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;

// delegate for itemDetailViewController
@property (nonatomic, weak) id <ItemDetailControllerDelegate> delegate;

-(IBAction)cancel;
-(IBAction)done;
// hooked up with switch value changed event
-(IBAction)switchChanged:(UISwitch *)sender;

@end
