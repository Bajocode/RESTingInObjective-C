//
//  FBPhotoStore.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBPhotoStore.h"
#import "FBFlickrAPI.h"

@implementation FBPhotoStore


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

// Test Impl
- (void)fetchInterestingPhotosWithCompletionHandler:(void (^)(NSArray*, NSError *))completion {
    NSURL *url = [[FBFlickrAPI sharedInstance] interestingPhotosURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *dataTask = [[self session] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self processInterestingPhotosRequestWithData:data urlResponse:response error:error completionHandler:^(NSArray *photos, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    completion(photos, nil);
                } else {
                    completion(nil, error);
                }
                
            });
        }];
        
    }];
    [dataTask resume];
}

// Process HTTP response
- (void)processInterestingPhotosRequestWithData:(NSData*)data
                                    urlResponse:(NSURLResponse *)response
                                          error:(NSError*)error
                              completionHandler:(void (^)(NSArray*, NSError *))processCompletion {
    if (data == nil) {
        processCompletion(nil, error);
    }
    // Cast into http response
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    if (httpResponse.statusCode == 200) {
        [[FBFlickrAPI sharedInstance] photoObjectsFromJson:data completionHandler:^(NSArray *photos, NSError * error) {
            processCompletion(photos, nil);
        }];
    }
}
    


@end
