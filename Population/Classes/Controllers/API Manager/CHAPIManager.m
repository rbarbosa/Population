//
//  CHAPIManager.m
//  Population
//
//  Created by Rui Pedro Barbosa on 06/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHAPIManager.h"

#import "CHCountry.h"
#import "CHNetworking.h"


NSString * const CountriesURL = @"http://www.androidbegin.com/tutorial/jsonparsetutorial.txt";


@interface CHAPIManager ()

@property (nonatomic, strong) NSArray *countries;

@end



@implementation CHAPIManager


// Public methods

#pragma mark - Get countries

- (void)fetchCountriesWithCompletionBlock:(countriesBlock)completionBlock
{
    [self arrayWithCountriesWithCompletionBlock:completionBlock];
}


#pragma mark - Get flag image

- (void)fetchFlagImageForCountry:(CHCountry *)country withCompletionBlock:(imageBlock)completion
{
    [CHNetworking fetchImageWithURL:country.flagURL
                    completionBlock:^(UIImage *image, NSError *error) {
                        if (!error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                completion(image);
                            });
                        } else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                UIImage *flagImage = [UIImage imageNamed:@"Apple-icon"];
                                completion(flagImage);
                            });
                        }
                    }];
}



// Private methods

#pragma mark - Array with countries

- (void)arrayWithCountriesWithCompletionBlock:(countriesBlock)countriesBlock
{
    // fetch json
    // store in an array
    NSURL *url = [NSURL URLWithString:CountriesURL];
    
    [CHNetworking fetchJSONWithURL:url
               withCompletionBlock:^(NSDictionary *json, NSError *error) {
                   if (!error) {
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



#pragma mark - Number from string

//TODO: Move to a category
- (NSNumber *)numberFromString:(NSString *)stringNumber
{
    // Remove any commas
    stringNumber = [stringNumber stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSNumber *number = [NSNumber numberWithDouble:[stringNumber doubleValue]];
    
    return number;
}

@end
