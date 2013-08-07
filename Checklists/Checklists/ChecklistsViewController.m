//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ChecklistsViewController.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController

NSMutableArray *items;

// before using an array
// ChecklistItem *row0Item, *row1Item, *row2Item, *row3Item, *row4Item;


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

    // initializing the mutable array
    items = [[NSMutableArray alloc] initWithCapacity:20];
    
    ChecklistItem *item;
    
    
    // initializing objects
    item = [[ChecklistItem alloc] init];
    item.text = @"Walk the dog";
    item.isChecked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Brush my teeth";
    item.isChecked = YES;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Learn iOS Development";
    item.isChecked = YES;
    [items addObject:item];
    
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Soccer practice";
    item.isChecked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Eat ice cream";
    item.isChecked = NO;
    [items addObject:item];
    
    /*
    item = [[ChecklistItem alloc] init];
    item.text = @"Call dad";
    item.isChecked = YES;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Update CV";
    item.isChecked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Wash the car";
    item.isChecked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Install the new SDK";
    item.isChecked = NO;
    [items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    item.text = @"Finish this app";
    item.isChecked = NO;
    [items addObject:item];
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* Table View Data Source Protocol */
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


// tells the table view the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}


// gets a cell for a given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // gets a copy of the prototype cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    ChecklistItem *item = [items objectAtIndex:indexPath.row];
    
    // setting the cell's text
    [self configureTextForCell:cell withChecklistItem:item];
    
    // setting the cell's checkmark
    [self configureCheckMarkForCell:cell withChecklistItem:item];
    
    return cell;
}


#pragma mark - Table view delegate

/**
 * changes checkmark in a given cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item = [items objectAtIndex:indexPath.row];
    
    // changes the checkmark
    [item toggleChecked];
    
    [self configureCheckMarkForCell:cell withChecklistItem:item];
    
    // deselects the tapped row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/**
 * configures the checkmark for a given cell
 */
- (void)configureCheckMarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if(item.isChecked)
    {
        label.text = @"✓";
    }
    else
    {
        label.text = @"";
    }
    // previous implementation before adding the detail disclosure button
    /*
    // setting the cell accessory type according to the local variable
    if(item.isChecked)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    */
}


/**
 * configures the text for a given cell
 */
-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *) item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}


/**
 * adds a new item to the checklist
 */
-(void)addItem
{
    // getting the current number of items
    int newRowIndex = [items count];
    
    // creating a new item and adding it to the array
    ChecklistItem *item = [[ChecklistItem alloc] init];
    item.text = @"New row";
    item.isChecked = YES;
    [items addObject:item];
    
    /* we have to "tell" the table view about the new row in the data model so that it can add a new cell for that row 
     as table views use index paths to identify rows, we need to make a new NSIndexPath object that points to the new row and 
     below we make the newIndexPoint pointing to the new row, using the row number */
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    /* as the method insertRowsAtIndexPaths uses not a single NSIndexPath object but, instead, an array of NSIndexPath, we have 
     to create that array */
    NSArray *indexPathArray = [NSArray arrayWithObject:newIndexPath];
    
    // adding the new row to the table view
    [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
}


/**
 * swipe-to-delete (using the built-in method)
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // removing the object from the data model
    [items removeObjectAtIndex:indexPath.row];
    
    // removing the corresponing row
    NSArray *newIndexPath = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:newIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];
}

/* protocol (delegate) methods (now the responsability of the DONE
 and CANCEL buttons are on the delegate */
-(void) addItemViewControllerDidCancel:(AddItemViewController *)controller
{
    // line below should work with self instead of controller??
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void) addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    // inserting a new item
    int newRowIndex = [items count];
    [items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // dismissing the screen
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void) addItemViewController:(AddItemViewController *)controller didFinishEdititingItem:(ChecklistItem *)item
{
    int index = [items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

/* "telling" AddItemViewController that ChecklistItemViewController is it's delegate */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // making sure we're dealing with the correct segue
    if([segue.identifier isEqualToString:@"AddItem"])
    {
        // the following controller is not AddItemViewController but instead the navigation that embeds it
        UINavigationController *navigationController = segue.destinationViewController;
        // noew we're getting the AddItemViewController
        AddItemViewController *controller = (AddItemViewController *) navigationController.topViewController;
        // setting AddItemViewController delegate as CheckListItemController
        controller.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        AddItemViewController *controller = (AddItemViewController *) navigationController.topViewController;
        controller.delegate = self;
        // sender contains the ChecklistItem to edit
        controller.itemToEdit = sender;
    }
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ChecklistItem *item = [items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}
@end
