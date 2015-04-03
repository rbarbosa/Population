//
//  CHNetworking.h
//  Population
//
//  Created by Rui Pedro Barbosa on 02/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^completionBlock)(BOOL success, NSDictionary *json);


@interface CHNetworking : NSObject

+ (void)fetchJSONWithURL:(NSURL *)url;

+ (void)fetchJSONWithURL:(NSURL *)url completionBlock:(completionBlock)completion;

@end
