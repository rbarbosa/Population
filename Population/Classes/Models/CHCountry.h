//
//  CHCountry.h
//  Population
//
//  Created by Rui Pedro Barbosa on 02/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CHCountry : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *population;
@property (nonatomic, assign) NSUInteger *rank;
@property (nonatomic, strong) NSURL *flagURL;


- (instancetype)initWithName:(NSString *)name
                  population:(NSNumber *)population
                        rank:(NSUInteger *)rank
                     flagURL:(NSURL *)flagURL;

@end
