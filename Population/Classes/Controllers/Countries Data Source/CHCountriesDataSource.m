//
//  CHCountriesDataSource.m
//  Population
//
//  Created by Rui Pedro Barbosa on 03/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//


#import "CHCountriesDataSource.h"

#import "CHCountry.h"



@implementation CHCountriesDataSource


#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        _countries = [NSArray array];
    }
    
    return self;
}




- (CHCountry *)countryAtIndexPath:(NSIndexPath *)indexPath
{
    CHCountry *country = [self.countries objectAtIndex:indexPath.row];
    
    return country;
}

- (NSUInteger)numberOfCountries
{
    return [self.countries count];
}

@end
