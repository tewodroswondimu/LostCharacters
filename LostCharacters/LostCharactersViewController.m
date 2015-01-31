//
//  ViewController.m
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LostCharactersViewController.h"
#import "AddLostCharacterViewController.h"
#import "LostCharacterDetailViewController.h"
#import "LostCharacterTableViewCell.h"
#import "LostCharacter.h"
#import "AppDelegate.h"

@interface LostCharactersViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSManagedObjectContext *context;
@property NSArray *lostCharacters;
@property NSMutableArray *managedObjects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LostCharactersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.context = delegate.managedObjectContext; 

    [self load];

    // Check if core data is empty
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

    [self.managedObjects addObject:lostCharacterData];
    [self.context save:nil];

    [self load];
}


- (void)load
{
    // Find all lost characters stored in your Lost Character's Entity
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"LostCharacter"];
    self.lostCharacters = [self.context executeFetchRequest:request error:nil];

    // Reorder the lost characters in alphabetical order
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"Actor" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.lostCharacters = [self.lostCharacters sortedArrayUsingDescriptors:sortDescriptors];

    [self.tableView reloadData];
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
    // Insert information into the cell
    LostCharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LostCharactersCell"];
    cell.name.text = [[self.lostCharacters objectAtIndex:indexPath.row] actor];
    cell.planeSeatLabel.text = [NSString stringWithFormat:@"%i, %@", 32, [[self.lostCharacters objectAtIndex:indexPath.row] passenger]];
    cell.ageLabel.text = [NSString stringWithFormat:@"%@ hair & %i yrs old", @"Blonde", 21];
    cell.profileImageView.image = [UIImage imageNamed:@"imagePlaceholder"];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        LostCharacter *lc = self.lostCharacters[indexPath.row];
        [self.context deleteObject:lc];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Helps you add more buttons to a tableviewcell swipe
//-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    return @"More! Ha ha ha!";
//}

- (IBAction)unwindViewControllerAdded:(UIStoryboardSegue *)segue
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Added Character" message:@"The character has been added" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alertView show];

    AddLostCharacterViewController *alcvc = segue.sourceViewController;
    LostCharacter *newLostCharacter = [alcvc theAddedLostCharacter];
    [self addToCoreData:newLostCharacter];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Detail"]) {
        LostCharacterDetailViewController *lcdvc = [segue destinationViewController];
        lcdvc.lostCharacter = self.lostCharacters[self.tableView.indexPathForSelectedRow.row];
        lcdvc.context = self.context;
        lcdvc.object = self.managedObjects[self.tableView.indexPathForSelectedRow.row];
    }
}

@end
