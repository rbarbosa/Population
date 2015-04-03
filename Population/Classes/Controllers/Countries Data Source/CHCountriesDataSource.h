//
//  CHCountriesDataSource.h
//  Population
//
//  Created by Rui Pedro Barbosa on 03/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^countriesBlock)(BOOL success, NSArray *countries);

@interface CHCountriesDataSource : NSObject

//- (void)createArrayWithCountries;

- (void)getCountriesWithCompletionBlock:(countriesBlock)completionBlock;

@end
