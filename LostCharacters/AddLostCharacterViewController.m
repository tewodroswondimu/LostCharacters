//
//  AddLostCharacterViewController.m
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "AddLostCharacterViewController.h"

@interface AddLostCharacterViewController ()

@property LostCharacter *addedLostCharacter;
@property (weak, nonatomic) IBOutlet UITextField *actorTextField;
@property (weak, nonatomic) IBOutlet UITextField *passengerTextField;

@end

@implementation AddLostCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.addedLostCharacter = [[LostCharacter alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    if (self.passengerTextField.text == nil || self.actorTextField.text == nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing Fields" message:@"Please fill all the fields in the form" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        self.addedLostCharacter.actor = self.actorTextField.text;
        self.addedLostCharacter.passenger = self.passengerTextField.text;
    }
}

- (LostCharacter *)theAddedLostCharacter
{
    self.addedLostCharacter.actor = self.actorTextField.text;
    self.addedLostCharacter.passenger = self.passengerTextField.text;
    return self.addedLostCharacter;
}

//- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Added Character" message:@"The character has been added" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//        [alertView show];
//    }];
//}

@end
