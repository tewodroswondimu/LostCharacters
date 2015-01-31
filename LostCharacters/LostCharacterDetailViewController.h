//
//  LostCharacterViewController.h
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LostCharacter.h"

@interface LostCharacterDetailViewController : UIViewController

@property LostCharacter *lostCharacter;

@property NSManagedObjectContext *context;
@property NSManagedObject *object; 

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hairColorLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *seatNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passengerTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *hairColorTextField;

@end
