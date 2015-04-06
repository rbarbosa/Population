//
//  CHAPIManager.h
//  Population
//
//  Created by Rui Pedro Barbosa on 06/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^countriesBlock)(BOOL success, NSArray *countries);


@interface CHAPIManager : NSObject

- (void)countriesWithCompletionBlock:(countriesBlock)completionBlock;

@end
