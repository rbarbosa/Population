//
//  CHCountriesDataSource.m
//  Population
//
//  Created by Rui Pedro Barbosa on 03/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHCountriesDataSource.h"

#import "CHCountry.h"
#import "CHNetworking.h"

NSString * const CountriesURL = @"http://www.androidbegin.com/tutorial/jsonparsetutorial.txt";


@interface CHCountriesDataSource ()

@property (nonatomic, strong) NSArray *countries;

@property (nonatomic, copy) countriesBlock countriesBlock;

@end



@implementation CHCountriesDataSource


#pragma mark - init

- (instancetype)init
{
    if (self = [super init]) {
        _countries = [NSArray array];
    }
    
    return self;
}

- (void)getCountriesWithCompletionBlock:(countriesBlock)completionBlock
{
//    [self createArrayWithCountriesWithCompletionBlock:completionBlock];
    
    self.countriesBlock = completionBlock;
    
    [self createArrayWithCountries];
}

#pragma mark - Create array with countries

- (void)createArrayWithCountries
{
    // fetch json
    // store in an array
    NSURL *url = [NSURL URLWithString:CountriesURL];
    [CHNetworking fetchJSONWithURL:url
                   completionBlock:^(BOOL success, NSDictionary *json) {
                       if (success) {
                           NSArray *countries = json[@"worldpopulation"];
                           [self createCountriesWithArray:countries];
                           self.countriesBlock(YES, self.countries);
                        }
                   }];
}

- (void)createArrayWithCountriesWithCompletionBlock:(countriesBlock)countriesBlock
{
    // fetch json
    // store in an array
    NSURL *url = [NSURL URLWithString:CountriesURL];
    [CHNetworking fetchJSONWithURL:url
                   completionBlock:^(BOOL success, NSDictionary *json) {
                       if (success) {
                           NSArray *countries = json[@"worldpopulation"];
                           [self createCountriesWithArray:countries];
                           countriesBlock(YES, self.countries);
                       } else {
                           countriesBlock(NO, self.countries);
                       }
                   }];
}

- (void)createCountriesWithArray:(NSArray *)countries
{
    // Reset array with countries, otherwise will add same countries
    NSMutableArray *newCountries = [NSMutableArray array];
    NSLog(@"%s [Line %d] countries: %@ ", __PRETTY_FUNCTION__, __LINE__,countries);

    [countries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *country = (NSDictionary *)obj;

        NSString *name = country[@"country"];
        NSString *flagURLString = country[@"flag"];
        NSNumber *rank = country[@"rank"];
        NSString *stringPopulation = country[@"population"];
        NSNumber *population = [self numberFromString:stringPopulation];
        
        // Create Country object
        CHCountry *newCountry = [[CHCountry alloc] initWithName:name
                                                  population:population
                                                        rank:rank
                                                     flagURL:[NSURL URLWithString:flagURLString]];
        
        [newCountries addObject:newCountry];
    }];
    
    // Set the array with countries
    self.countries = [NSArray arrayWithArray:newCountries];
}


- (NSNumber *)numberFromString:(NSString *)stringNumber
{
    // Remove any commas
    stringNumber = [stringNumber stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSNumber *number = [NSNumber numberWithDouble:[stringNumber doubleValue]];
    
    return number;
}



@end
