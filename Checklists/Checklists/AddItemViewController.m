//
//  AddItemViewController.m
//  Checklists
//
//  Created by João Carreira on 8/4/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

@synthesize textField, doneBarButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// pressing the "Done" button on the navigation bar
-(IBAction)done
{
    NSLog(@"Contents of the text field: %@", textField.text);
    
    // the preseting view controller is the UINavigationController
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// pressing the "Cancel" button on the navigation bar
-(IBAction)cancel
{
    // the preseting view controller is the UINavigationController
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

// disabling selections in a row
-(NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)viewDidUnload {
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // automatically toggling the textfield (aka, giving the control focus)
    [self.textField becomeFirstResponder];
}

// verifies if text field is empty 
-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newText length] > 0);
    
    // the if-else below is equivalent to above
    /*
    if([newText length] > 0)
    {
        self.doneBarButton.enabled = YES;
    }
    else
    {
        self.doneBarButton.enabled = NO;
    }
    */
    
    return YES;
    /* the Done button is initially enabled when the Add Item screen opens, 
     but there is no text in the text field at that point so it really should be disabled. 
     This is simple enough to fix: in the Storyboard editor, select the Done bar button and go to the Attributes Inspector and uncheck the Enabled box. */
}

@end
