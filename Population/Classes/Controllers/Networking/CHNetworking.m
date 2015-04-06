//
//  CHNetworking.m
//  Population
//
//  Created by Rui Pedro Barbosa on 02/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHNetworking.h"

typedef void(^taskBlock)(NSData *data, NSURLResponse *response, NSError *error);

@implementation CHNetworking



// Public methods

#pragma mark - Fetch image

+ (void)fetchImageWithURL:(NSURL *)imageURL completionBlock:(imageCompletionBlock)completion
{
    [CHNetworking taskWithURL:imageURL
              completionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                  if (httpResponse.statusCode == 200) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          UIImage *image = [UIImage imageWithData:data];
                          completion(image, error);
                      });
                  }
              }];
}



#pragma mark - Fetch json

+ (void)fetchJSONWithURL:(NSURL *)url withCompletionBlock:(JSONCompletionBlock)completion
{
    [CHNetworking taskWithURL:url
              completionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
                  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                  if (httpResponse.statusCode == 200) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [CHNetworking handleJSONResults:data
                                      withCompletionBlock:completion];
                      });
                  }
              }];
}



// Private methods

#pragma mark - Create task for url

+ (void)taskWithURL:(NSURL *)url completionBlock:(taskBlock)completion
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   completion(data, response, error);
               }];
    
    [task resume];
}



#pragma mark - Handle JSON results

+ (void)handleJSONResults:(NSData *)data withCompletionBlock:(JSONCompletionBlock)completion
{
    NSError *JSONError;
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&JSONError];
    
    if (response) {
        completion(response, JSONError);
    } else {
        NSLog(@"ERROR: %@", JSONError);
    }
}

@end
