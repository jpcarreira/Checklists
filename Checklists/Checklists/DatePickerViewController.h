//
//  DatePickerViewController.h
//  Checklists
//
//  Created by João Carreira on 8/16/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>

// defining a delegate protocol to allow the date picker to send messages back to the ItemDetailViewController
@class DatePickerViewController;
@protocol DatePickerViewControllerDelegate <NSObject>
-(void)datePickerDidCancel:(DatePickerViewController *)picker;
-(void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date;
@end

@interface DatePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <DatePickerViewControllerDelegate> delegate;
// this is the date that will initially be displayed in the screen
@property (nonatomic, strong) NSDate *date;

-(IBAction)cancel;
-(IBAction)done;
// this is connected to valueChanged event in the DatePicker object
-(IBAction)dateChanged;

@end
