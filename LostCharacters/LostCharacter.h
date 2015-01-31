//
//  LostCharacter.h
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LostCharacter : NSObject

@property NSString *actor;
@property NSString *passenger;

@property NSString *imageURL;
@property NSString *hairColor;

@property BOOL gender;
@property int seatNumber;
@property int age;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
