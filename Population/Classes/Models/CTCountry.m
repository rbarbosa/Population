//
//  CTCountry.m
//  Population
//
//  Created by Rui Pedro Barbosa on 02/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CTCountry.h"


@implementation CTCountry


- (instancetype)initWithName:(NSString *)name
                  population:(NSNumber *)population
                        rank:(NSUInteger *)rank
                     flagURL:(NSURL *)flagURL
{
    if (self = [super init]) {
        _name = name;
        _population = population;
        _rank = rank;
        _flagURL = flagURL;
    }
    
    return self;
}

@end
