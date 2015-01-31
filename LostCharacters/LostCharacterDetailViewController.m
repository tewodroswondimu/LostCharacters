//
//  LostCharacterViewController.m
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LostCharacterDetailViewController.h"

@interface LostCharacterDetailViewController ()

@end

@implementation LostCharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.layer.cornerRadius = 20;
    self.imageView.layer.masksToBounds = YES;

    self.nameLabel.text = self.lostCharacter.actor;
    self.passengerLabel.text = self.lostCharacter.passenger;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)editButtonTapped:(UIBarButtonItem *)sender
{
    if (!self.editing) {
        self.nameTextField.hidden = NO;
        self.passengerTextField.hidden = NO;
        self.seatNumberTextField.hidden = NO;
        self.genderTextField.hidden = NO;
        self.ageTextField.hidden = NO;
        self.hairColorTextField.hidden = NO;
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
    else if (self.editing)
    {
        self.nameTextField.hidden = YES;
        self.passengerTextField.hidden = YES;
        self.seatNumberTextField.hidden = YES;
        self.genderTextField.hidden = YES;
        self.ageTextField.hidden = YES;
        self.hairColorTextField.hidden = YES;
        sender.style = UIBarButtonSystemItemEdit;
        sender.title = @"Edit";
    }
    self.editing = !self.editing;
}

@end
