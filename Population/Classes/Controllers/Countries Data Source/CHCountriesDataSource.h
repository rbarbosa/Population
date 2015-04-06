//
//  CHCountriesDataSource.h
//  Population
//
//  Created by Rui Pedro Barbosa on 03/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CHCountry;

@interface CHCountriesDataSource : NSObject

@property (nonatomic, strong) NSArray *countries;


- (CHCountry *)countryAtIndexPath:(NSIndexPath *)indexPath;

- (NSUInteger)numberOfCountries;


@end
