//
//  CHAPIManager.h
//  Population
//
//  Created by Rui Pedro Barbosa on 06/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CHCountry;

typedef void(^countriesBlock)(NSArray *countries, NSError *error);
typedef void(^imageBlock)(UIImage *image);


@interface CHAPIManager : NSObject

- (void)fetchCountriesWithCompletionBlock:(countriesBlock)completionBlock;

- (void)fetchFlagImageForCountry:(CHCountry *)country withCompletionBlock:(imageBlock)completion;

@end
