//
//  IconPickerViewController.h
//  Checklists
//
//  Created by João Carreira on 8/13/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import <UIKit/UIKit.h>

// defining a delegate
@class IconPickerViewController;
@protocol IconPickerViewControllerDelegate<NSObject>
-(void)iconPicker: (IconPickerViewController *)picker didPickIcon:(NSString *)iconName;
@end

@interface IconPickerViewController : UITableViewController

@property (nonatomic, weak) id <IconPickerViewControllerDelegate> delegate;

@end
