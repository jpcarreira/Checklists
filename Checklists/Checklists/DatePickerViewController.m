//
//  DatePickerViewController.m
//  Checklists
//
//  Created by João Carreira on 8/16/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

@synthesize tableView, datePicker, delegate, date;

UILabel *dateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // setting the current date shown in the datepicker with the current date
    [self.datePicker setDate:self.date animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"DateCell"];
    // looks for the label with tag 1000 and puts it in the ivar
    dateLabel = (UILabel *)[cell viewWithTag:1000];
    [self updateDateLabel];
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // igoring any taps on the rows
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
}

#pragma mark - instance methods

/**
 * storing the picked date with DatePicker in the ivar
 */
-(void)dateChanged
{
    self.date = [self.datePicker date];
    [self updateDateLabel];
}

-(void)updateDateLabel
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [dateFormatter stringFromDate:self.date];
}


#pragma mark - Actions

-(void)cancel
{
    [self.delegate datePickerDidCancel:self];
}

-(void)done
{
    [self.delegate datePicker:self didPickDate:self.date];
}

@end
