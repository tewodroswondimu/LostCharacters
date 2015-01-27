//
//  ViewController.m
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LostCharactersViewController.h"
#import "LostCharacter.h"
#import "AppDelegate.h"

@interface LostCharactersViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSManagedObjectContext *context;
@property NSArray *lostCharacters;

@end

@implementation LostCharactersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext; 

    [self load];
    if (self.lostCharacters.count) {
        NSLog(@"Core Data is not empty!");
    }
    else
    {
        NSArray *lostCharacterArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"]];
        for (NSDictionary *lostCharacterDictionary in lostCharacterArray)
        {
            LostCharacter *lostCharacter = [[LostCharacter alloc] initWithDictionary:lostCharacterDictionary];
            [self addToCoreData:lostCharacter];
        }
    }
}

#pragma mark CORE DATA

- (void)addToCoreData:(LostCharacter *)lostCharacter
{

    NSManagedObject *lostCharacterData = [NSEntityDescription insertNewObjectForEntityForName:@"LostCharacter" inManagedObjectContext:self.context];

    // Saves to the name
    [lostCharacterData setValue:lostCharacter.actor forKey:@"actor"];
    [lostCharacterData setValue:lostCharacter.passenger forKey:@"passenger"];

    [self.context save:nil];

    [self load];
}

- (void)load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"LostCharacter"];

    self.lostCharacters = [self.context executeFetchRequest:request error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TABLE VIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lostCharacters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LostCharactersCell"];
    return cell;
}

@end
