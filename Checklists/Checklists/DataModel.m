//
//  DataModel.m
//  Checklists
//
//  Created by João on 8/11/13.
//  Copyright (c) 2013 João Carreira. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

@synthesize lists;

/**
 * method that changes NSUserDefaults "default value" to -1
 * to avoid a crash when the app starts
 */
-(void)registerDefaults
{
    // setting the standard
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:-1], @"ChecklistIndex", nil];
    
    // giving the standard to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(id)init
{
    if((self = [super init]))
    {
        [self loadChecklists];
        [self registerDefaults];
    }
    return self;
}

#pragma mark - save/load methods

/**
 * gets documents directory
 */
-(NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

/**
 * gets data file path
 */
-(NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

/**
 * saves data
 */
-(void)saveChecklists
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Checklists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

/**
 * loads data
 */
-(void)loadChecklists
{
    NSString *path = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
        [unarchiver finishDecoding];
    }
    else
    {
        self.lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

#pragma mark - NSUserDefaults

-(int)getIndexOfSelectedChecklist
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

-(void)setIndexOfSelectedChecklist:(int)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

@end
