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

@synthesize textField;

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
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // automatically toggling the textfield (aka, giving the control focus)
    [self.textField becomeFirstResponder];
}
@end
