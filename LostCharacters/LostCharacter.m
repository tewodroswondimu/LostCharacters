//
//  LostCharacter.m
//  LostCharacters
//
//  Created by Tewodros Wondimu on 1/27/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LostCharacter.h"

@implementation LostCharacter

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    self.actor = dictionary[@"actor"];
    self.passenger = dictionary[@"passenger"];

    return self;
}

@end
