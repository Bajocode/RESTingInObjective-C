//
//  PhotoStore.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 02/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "PhotoStore.h"
#import "FBFlickrAPI.h"

@implementation PhotoStore


#pragma mark - Properties

- (NSURLSession *)session {
    static dispatch_once_t pred = 0;
    __strong static NSURLSession *_session = nil;
    // Initialize once
    dispatch_once(&pred, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    });
    return _session;
}


#pragma mark - Methods

- (void)fetchInterestingPhotos {
    NSURL *url = [[FBFlickrAPI sharedInstance] interestingPhotosURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *dataTask = [[self session] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", data);
        }
    }];
    [dataTask resume];
}

@end
