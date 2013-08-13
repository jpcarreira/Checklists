//
//  ListDetailViewController.m
//  Checklists
//
//  Created by João Carreira on 8/10/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

@synthesize textField, doneBarButton, delegate, checklistToEdit;

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
    if(self.checklistToEdit != nil)
    {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Buttons

-(IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

-(IBAction)done
{
    if(self.checklistToEdit == nil)
    {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }
    else
    {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEdititingChecklist:checklistToEdit];
    }
}

-(NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this will allow to tap the row corresponding to icon select (tapping the first row is still not enabled though)
    if(indexPath.row == 1)
    {
        return indexPath;
    }
    else
    {
        return nil;
    }
}


-(BOOL) textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)viewDidUnload {
    [self setIconImageView:nil];
    [super viewDidUnload];
}
@end
