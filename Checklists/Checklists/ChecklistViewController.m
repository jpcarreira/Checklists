//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ChecklistViewController.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

@synthesize checklist;

// deprecated with new data model
//NSMutableArray *items;

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

// deprecated with new data model
/*
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        [self loadChecklistItems];
    }
    return self;
}
*/

/**
 * loading data from the pList file
 */
// deprecated with new data model
/*
-(void) loadChecklistItems
{
    NSString *path = [self dataFilePath];
    
    // verifies if pList file already exists
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        // loading contents of pList to NSData object
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        // populates the mutable array with that pList data
        items = [unarchiver decodeObjectForKey:@"ChecklistItems"];
        [unarchiver finishDecoding];
    }
    else
    {
        items = [[NSMutableArray alloc] initWithCapacity:20];
    }
}
*/

/**
 * gets the full path of the documents directory in a iOS device
 */
// deprecated with new data model
/*
-(NSString *) getDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
*/

/**
 * returns the full path for the file used to persist data
 */
// deprecated with new data model
/*
-(NSString *) dataFilePath
{
    return [[self getDocumentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}
*/

/**
 * saves checklist items using serialization
 */
// deprecated with new data model
/*
-(void) saveCheckListItems
{
    // data object that will be written in the pList file
    NSMutableData *data = [[NSMutableData alloc] init];
    // a form of NSCoder that creates plist files, encodes the array and all the ChecklistItems in it into some sort of binary data format that can be written to a file 
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:items forKey:@"ChecklistItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // showing the correct tile for the checklist
    self.title = self.checklist.name;
    
    //NSLog(@"%@", [self getDocumentsDirectory]);

    // below we have code to add "fake" items (used before save/load data was implemented)
    
    
    /*
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
    return [self.checklist.items count];
}


// gets a cell for a given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // gets a copy of the prototype cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    ChecklistItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    
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
    
    ChecklistItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    
    // changes the checkmark
    [item toggleChecked];
    
    [self configureCheckMarkForCell:cell withChecklistItem:item];
    
    // saving changed array with modified checkmarks
    // deprecated with new data model
    //[self saveCheckListItems];
    
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
    // uncomment below to test ChecklistItemID
    //label.text = [NSString stringWithFormat:@"%@ - %d", item.text, item.itemId];
}


/**
 * adds a new item to the checklist
 */
-(void)addItem
{
    // getting the current number of items
    int newRowIndex = [self.checklist.items count];
    
    // creating a new item and adding it to the array
    ChecklistItem *item = [[ChecklistItem alloc] init];
    item.text = @"New row";
    item.isChecked = YES;
    [self.checklist.items addObject:item];
    
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
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    
    // saving changed array that no longer counts with deleted object
    // deprecated with new data model
    //[self saveCheckListItems];
    
    // removing the corresponing row
    NSArray *newIndexPath = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:newIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];
}

/* protocol (delegate) methods (now the responsability of the DONE
 and CANCEL buttons are on the delegate */
-(void) itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    // line below should work with self instead of controller??
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void) itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    // inserting a new item
    int newRowIndex = [self.checklist.items count];
    [self.checklist.items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // saving changed array with new added object
    // deprecated with new data model
    //[self saveCheckListItems];
    
    // dismissing the screen
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void) itemDetailViewController:(ItemDetailViewController *)controller didFinishEdititingItem:(ChecklistItem *)item
{
    int index = [self.checklist.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    
    // saving changed array with new edited object
    // deprecated with new data model
    //[self saveCheckListItems];
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

/* "telling" itemDetalViewController that ChecklistItemViewController is it's delegate */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // making sure we're dealing with the correct segue
    if([segue.identifier isEqualToString:@"AddItem"])
    {
        // the following controller is not itemDetailViewController but instead the navigation that embeds it
        UINavigationController *navigationController = segue.destinationViewController;
        // noew we're getting the itemDetailViewController
        ItemDetailViewController *controller = (ItemDetailViewController *) navigationController.topViewController;
        // setting itemDetailViewController delegate as CheckListItemController
        controller.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
        // sender contains the ChecklistItem to edit
        controller.itemToEdit = sender;
    }
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ChecklistItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}
@end
