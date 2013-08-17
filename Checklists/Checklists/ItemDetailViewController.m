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

// ivars to store screen's content of text and switch control status
NSString *text;
BOOL shouldRemind;

@synthesize textField, doneBarButton, delegate, itemToEdit, switchControl, dueDateLabel;

// instance variable for due date that is shown in the screen
NSDate *dueDate;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        text = @"";
        shouldRemind = NO;
        dueDate = [NSDate date];
    }
    return self;
}

-(void)updateDoneBarButton
{
    self.doneBarButton.enabled = ([text length] > 0);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // before editing didReceiceMemoryWarning
    /*
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
     */
    if(self.itemToEdit != nil)
    {
        self.title = @"Edit item";
    }
    self.textField.text = text;
    self.switchControl.on = shouldRemind;
    
    [self updateDoneBarButton];
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

/**
 * this method is called when memory is low
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }
    else if(![self isViewLoaded])
    {
        self.textField = nil;
        self.doneBarButton = nil;
        self.switchControl = nil;
        self.dueDateLabel = nil;
    }
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
    // deprecated since edited didReceiveMemoryWarning
    /*
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newText length] > 0);
    */
     
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
    
    // new code since edited didReceiveMemoryWarning 
    text = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateDoneBarButton];
    
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

-(IBAction)switchChanged:(UISwitch *)sender
{
    shouldRemind = sender.on;
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

-(void)textFieldDidEndEditing:(UITextField *)theTextField
{
    // if there is a spelling suggestion and the user presses Done on the keyboard, the text in the text field does change but we do not get a shouldChangeCharactersInRange notification so we handle that situation in textFieldDidEndEditing
    text = theTextField.text;
    [self updateDoneBarButton];
}

@end
