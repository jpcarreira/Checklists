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

#pragma mark - instance methods

/**
 * storing the picked date with DatePicker in the ivar
 */
-(void)dateChanged
{
    self.date = [self.datePicker date];
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
