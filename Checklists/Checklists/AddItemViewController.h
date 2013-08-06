//
//  AddItemViewController.h
//  Checklists
//
//  Created by João Carreira on 8/4/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>

/* defining a custom delegate so that AddItemViewController can
 communicate back to to CheckListItemViewController; the 
 delegate also needs the property shown after @interface */
@class AddItemViewController;
@class ChecklistItem;
@protocol AddItemViewControllerDelegate <NSObject>
-(void)addItemViewControllerDidCancel:(AddItemViewController *) controller;
-(void)addItemViewController:(AddItemViewController *) controller didFinishAddingItem:(ChecklistItem *) item;
@end

/* added UITextFieldDelegate to make the ViewController a delegate of the TextField: 
 this allows the view controller to check whether there's text, 
 or not, in the textfield */
@interface AddItemViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

// delegate for AddItemViewController
@property (nonatomic, weak) id <AddItemViewControllerDelegate> delegate;

-(IBAction)cancel;
-(IBAction)done;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@end
