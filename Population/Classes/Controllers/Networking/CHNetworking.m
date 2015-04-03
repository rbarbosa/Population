//
//  CHNetworking.m
//  Population
//
//  Created by Rui Pedro Barbosa on 02/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHNetworking.h"


@implementation CHNetworking


+ (void)fetchJSONWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   // Check response
                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                   if (httpResponse.statusCode == 200) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [CHNetworking handleDataResults:data];
                       });
                   } else {
                       // There was error
                       NSString *body = [[NSString alloc] initWithData:data
                                                              encoding:NSUTF8StringEncoding];
                       // Create alert
                       NSLog(@"ERROR!\n Received HTTP %ld: %@", (long)httpResponse.statusCode, body);
                   }
               }];
    
    [task resume];
}

+ (void)handleDataResults:(NSData *)data
{
    NSError *JSONError;
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&JSONError];
    
    if (response) {
        NSLog(@"Response: %@", response);
    } else {
        NSLog(@"ERROR: %@", JSONError);
    }
    
}

@end
