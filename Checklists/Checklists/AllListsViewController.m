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
#import "ListDetailViewController.h"
#import "ChecklistItem.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

// an array to store Checklist objects
// not needed anymore since using DataModel object
// NSMutableArray *lists;

@synthesize dataModel;

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
        self.dataModel = [[DataModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // making this AllListsViewController as the delegate
    self.navigationController.delegate = self;
    // getting the value stored in the NSUserDefaults
    int index = [self.dataModel getIndexOfSelectedChecklist];
    /* going the user's last viewed checklist (if the value is not
     -1 then it means the user was viewing some checklist at the 
     point the app was exited) */
    /* checking if both Checklists.plist and NSUserDefaults are 
     "in sync", that is, the above condition prevents a crash 
     when, for example, NSUserDefaults gets sucessfully updated 
     but the Checklist object wasn't added to the plist */
    if(index >= 0 && index < [self.dataModel.lists count])
    {
        Checklist *checklist = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // loading the list in the array into the cells
    Checklist *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Remaining: %d", [checklist countUncheckedItems]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
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
    // saving the tapped row in NSUserDefaults
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    
    Checklist *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
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
    else if([segue.identifier isEqualToString:@"AddChecklist"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist
{
    int newRowIndex = [self.dataModel.lists count];
    [self.dataModel.lists addObject:checklist];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEdititingChecklist:(Checklist *)checklist
{
    int index = [self.dataModel.lists indexOfObject:checklist];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = checklist.name;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * delegate method that detects when user taps the accessory button
 * (instead of using the segue as we do on ChecklistViewController)
 */
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // creating the navigation controller; the identifier must be coherent with the ID in the "identity inspector" of the navigation controller, in the storyboard
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationViewController"];
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    Checklist *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
    controller.checklistToEdit = checklist;
    
    // preseting the navigation controller in the screen
    [self presentViewController:navigationController animated:YES completion:nil];
}

/**
 * delegate method to check if user taps the back button
 */
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /* if the back button is pressed then the viewcontroller will 
     be the AllListViewController itself so we can set ChecklistIndex
     in NSUserDefaults to -1 */
    if(viewController == self)
    {
        [self.dataModel setIndexOfSelectedChecklist:-1];
    }
}

@end
