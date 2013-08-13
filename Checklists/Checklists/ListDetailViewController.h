//
//  ListDetailViewController.h
//  Checklists
//
//  Created by João Carreira on 8/10/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListDetailViewController;
@class Checklist;
@protocol ListDetailViewControllerDelegate <NSObject>
-(void)listDetailViewControllerDidCancel:(ListDetailViewController *) controller;
-(void)listDetailViewController:(ListDetailViewController *) controller didFinishAddingChecklist:(Checklist *) checklist;
-(void)listDetailViewController:(ListDetailViewController *) controller didFinishEdititingChecklist:(Checklist *) checklist;
@end


@interface ListDetailViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, strong) Checklist *checklistToEdit;

@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;


-(IBAction)cancel;
-(IBAction)done;

@end
