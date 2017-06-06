//
//  FBPhotoStore.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBPhotoStore.h"
#import "FBFlickrAPI.h"
#import "FBPhoto.h"
#import "FBImageStore.h"

@interface FBPhotoStore ()

@property (nonatomic) FBImageStore *imageStore;

@end

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


#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        // Setup
        self.imageStore = [[FBImageStore alloc] init];
    }
    return self;
}


#pragma mark - Methods

// Fetch image for photo
- (void)fetchImageForPhoto:(FBPhoto *)photo completionHandler:(void (^)(UIImage*, NSError *))completion {
    // Check cache and disk first
    NSString *key = photo.photoID;
    UIImage *image = [self.imageStore imageForKey:key];
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image, nil);
        });
        return;
    }
    
    // Not found? Make new request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:photo.remoteURL];
    NSURLSessionDataTask *dataTask = [[self session] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self processImageRequestWithData:data urlResponse:response error:error completionHandler:^(UIImage *image, NSError *error) {
            // Dispatch back on main, pass image
                if (image) {
                    [self.imageStore setImage:image forKey:key];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(image, nil);
                    });
                }
        }];
    }];
    [dataTask resume];
}



// Process HTTP image response
- (void)processImageRequestWithData:(NSData*)data
                                    urlResponse:(NSURLResponse *)response
                                          error:(NSError*)error
                              completionHandler:(void (^)(UIImage*, NSError *))processCompletion {
    if (data == nil) {
        processCompletion(nil, error);
    }
    // Cast into http response
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    if (httpResponse.statusCode == 200) {
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            processCompletion(image, nil);
        } else {
            NSLog(@"Could not convert imagedata");
        }
    } else {
        processCompletion(nil, error);
    }
}


// Fetch interesting photo
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
