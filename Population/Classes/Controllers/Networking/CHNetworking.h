//
//  CHNetworking.h
//  Population
//
//  Created by Rui Pedro Barbosa on 02/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^imageCompletionBlock)(UIImage *image, NSError *error);
typedef void(^JSONCompletionBlock)(NSDictionary *json, NSError *error);

@interface CHNetworking : NSObject

+ (void)fetchJSONWithURL:(NSURL *)url withCompletionBlock:(JSONCompletionBlock)completion;

+ (void)fetchImageWithURL:(NSURL *)imageURL completionBlock:(imageCompletionBlock)completion;

@end
