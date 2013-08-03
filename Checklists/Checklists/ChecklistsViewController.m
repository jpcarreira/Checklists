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

ChecklistItem *row0Item, *row1Item, *row2Item, *row3Item, *row4Item;


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

    // initializing objects
    row0Item = [[ChecklistItem alloc] init];
    row0Item.text = @"Walk the dog";
    row0Item.isChecked = NO;
    
    row1Item = [[ChecklistItem alloc] init];
    row1Item.text = @"Brush my teeth";
    row1Item.isChecked = YES;
    
    row2Item = [[ChecklistItem alloc] init];
    row2Item.text = @"Learn iOS Development";
    row2Item.isChecked = YES;
    
    row3Item = [[ChecklistItem alloc] init];
    row3Item.text = @"Soccer practice";
    row3Item.isChecked = NO;
    
    row4Item = [[ChecklistItem alloc] init];
    row4Item.text = @"Eat ice cream";
    row4Item.isChecked = NO;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

// tells the table view the number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// gets a cell for a given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // gets a copy of the prototype cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    UILabel *label = (UILabel *) [cell viewWithTag:1000];
    
    // setting the cell's label text
    if(indexPath.row == 0)
    {
        label.text = row0Item.text;
    }
    else if(indexPath.row == 1)
    {
        label.text = row1Item.text;
    }
    else if(indexPath.row == 2)
    {
        label.text = row2Item.text;
    }
    else if(indexPath.row == 3)
    {
        label.text = row3Item.text;
    }
    else if(indexPath.row == 4)
    {
        label.text = row4Item.text;
    }
    
    // setting the cell's checkmark
    [self configureCheckMarkForCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

/**
 * changes checkmark in a given cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row == 0)
    {
        row0Item.isChecked = !row0Item.isChecked;
    }
    else if(indexPath.row == 1)
    {
        row1Item.isChecked = !row1Item.isChecked;
    }
    else if(indexPath.row == 2)
    {
        row2Item.isChecked = !row2Item.isChecked;
    }
    else if(indexPath.row == 3)
    {
        row3Item.isChecked = !row3Item.isChecked;
    }
    else if(indexPath.row == 4)
    {
        row4Item.isChecked = !row4Item.isChecked;
    }
    
    [self configureCheckMarkForCell:cell atIndexPath:indexPath];
    
    // deselects the tapped row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/**
 * configures the checkmark for a given cell
 */
- (void)configureCheckMarkForCell:(UITableViewCell *) cell atIndexPath:(NSIndexPath *) indexPath
{
    // local variable to store checked status
    BOOL isChecked = NO;
    
    // getting the corresponsping object and storing isChecked attribute in local variable
    if(indexPath.row == 0)
    {
        isChecked = row0Item.isChecked;
    }
    else if(indexPath.row == 1)
    {
        isChecked = row1Item.isChecked;
    }
    else if(indexPath.row == 2)
    {
        isChecked = row2Item.isChecked;
    }
    else if(indexPath.row == 3)
    {
        isChecked = row3Item.isChecked;
    }
    else if(indexPath.row == 4)
    {
        isChecked = row4Item.isChecked;
    }
    
    // setting the cell accessory type according to the local variable
    if(isChecked)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
