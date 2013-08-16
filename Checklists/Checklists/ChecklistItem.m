//
//  ChecklistItem.m
//  Checklists
//
//  Created by João Carreira on 8/3/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

@synthesize text, isChecked, dueDate, shouldRemind, itemId;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init]))
    {
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.isChecked = [aDecoder decodeBoolForKey:@"isChecked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntForKey:@"ItemID"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeBool:self.isChecked forKey:@"isChecked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemID"];
}

-(id)init
{
    if(self = [super init])
    {
        // calling the method responsible to give an ID to the checklist item
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

-(void)toggleChecked
{
    self.isChecked = !self.isChecked;
}

/**
 * verifices if the current checklist item has already a local notification associated to it
 */
-(UILocalNotification *)notificationForThisItem
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in allNotifications)
    {
        // stores the item ID
        NSNumber *notificationID = [notification.userInfo objectForKey:@"ItemID"];
        // if the ID is equal to the existing ID in the notifications array
        if((notificationID != nil) && ([notificationID intValue] == self.itemId))
        {
            // then we already have a notification for this item and return it
            return notification;
        }
    }
    // otherwise we return nil
    return nil;
}

/**
 * schedules a new LocalNotification for a given checklist item
 */
-(void)scheduleNotification
{
    // dealing with existing notifications
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification != nil)
    {
        NSLog(@"Found an existing notification: %@", existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }

    
    
    // we only schedule a notification if it's checked for it and if the date is not in the past
    if(self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending)
    {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        // this is important to "mark" the notification in case we want to find and cancel it later
        localNotification.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        NSLog(@"Item: %@ -- Key: %d", localNotification, self.itemId);
    }
}


@end
