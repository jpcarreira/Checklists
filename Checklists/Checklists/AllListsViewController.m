//
//  AllListsViewController.m
//  Checklists
//
//  Created by João Carreira on 8/9/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

// an array to store Checklist objects
NSMutableArray *lists;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

/**
 * data model goes here: this view controller is part of a storyboard so it will allways be initialized
 * with initWithCoder
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        // adding "fake" data
        lists = [[NSMutableArray alloc] initWithCapacity:20];
        
        Checklist *list;
        
        list = [[Checklist alloc] init];
        list.name = @"Birthdays";
        [lists addObject:list];
        
        list = [[Checklist alloc] init];
        list.name = @"Groceries";
        [lists addObject:list];
        
        list = [[Checklist alloc] init];
        list.name = @"Cool apps";
        [lists addObject:list];
        
        list = [[Checklist alloc] init];
        list.name = @"To do";
        [lists addObject:list];
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
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // loading the list in the array into the cells
    Checklist *checklist = [lists objectAtIndex:indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}


#pragma mark - Table view delegate
/**
 * this table view delegate method is invoked when we tap a row. In the ChecklistItemViewController we worked with prototype cells and a tap in a row
 * would automatically perform the segue because the segue was hooked up with the prototype cell. In this case the segue has to be performed manually
 * by calling performSegueWithIdentifier with the name of the segue
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Checklist *checklist = [lists objectAtIndex:indexPath.row];
    // sending the Checklist object corresponding to the row the user taps on
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowChecklist"])
    {
        ChecklistViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    }
}


@end
