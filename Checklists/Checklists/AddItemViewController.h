//
//  AddItemViewController.h
//  Checklists
//
//  Created by João Carreira on 8/4/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>

/* added UITextFieldDelegate to make the ViewController a delegate of the TextField: 
 this allows the view controller to check whether there's text, 
 or not, in the textfield */
@interface AddItemViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

-(IBAction)cancel;
-(IBAction)done;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@end
