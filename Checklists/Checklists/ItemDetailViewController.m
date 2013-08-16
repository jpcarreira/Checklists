//
//  ItemDetailViewController.m
//  Checklists
//
//  Created by João Carreira on 8/4/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ItemDetailViewController.h"
// added after adding the delegate
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

@synthesize textField, doneBarButton, delegate, itemToEdit, switchControl, dueDateLabel;

// instance variable for due date that is shown in the screen
NSDate *dueDate;

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
    
    if(self.itemToEdit != nil)
    {
        self.title = @"Edit item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
        // with an existing checklist item the switch being on or off will depend on the item status
        self.switchControl.on = self.itemToEdit.shouldRemind;
        dueDate = self.itemToEdit.dueDate;
    }
    else
    {
        // with a new checklist item the control is always off
        self.switchControl.on = NO;
        // gets the current date -> change it for tomorrow date???
        dueDate = [NSDate date];
    }
    [self updateDueDateLabel];
}

/**
 * updates the date label
 */
-(void) updateDueDateLabel
{
    // NSDateFormatter converts a NSDate to text
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [dateFormatter stringFromDate:dueDate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// pressing the "Done" button on the navigation bar
-(IBAction)done
{
    // before defining a itemDetailViewController delegate
    /*
    NSLog(@"Contents of the text field: %@", textField.text);
    // the preseting view controller is the UINavigationController
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     */
    
    // after adding the delegate
    if(self.itemToEdit == nil)
    {
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = self.textField.text;
        item.isChecked = NO;
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        
        [item scheduleNotification];
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    else
    {
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        
        [itemToEdit scheduleNotification];
        [self.delegate itemDetailViewController:self didFinishEdititingItem:itemToEdit];
    }
    
}

// pressing the "Cancel" button on the navigation bar
-(IBAction)cancel
{
    // before defining a itemDetailViewController delegate
    /*
    // the preseting view controller is the UINavigationController
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil]; 
     */
    
    // after adding the delegate
    [self.delegate itemDetailViewControllerDidCancel:self];
}

// disabling selections in a row (except for date picking)
-(NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        return indexPath;
    }
    else
    {
        return nil;
    }
}

- (void)viewDidUnload {
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [self setDueDateLabel:nil];
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

/**
 * making the current view controller a delegate of DatePickerViewController
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PickDate"])
    {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        // setting the current date in this view controller to the datepicker
        controller.date = dueDate;
    }
}

#pragma mark - Delegate methods DatePickerViewController

-(void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
