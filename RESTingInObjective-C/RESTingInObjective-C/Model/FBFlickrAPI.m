//
//  FBFlickrAPI.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBFlickrAPI.h"
#import "FBPhoto.h"

@implementation FBFlickrAPI

#pragma mark - Constants

NSString *const baseURLString = @"https://api.flickr.com/services/rest";
NSString *const apiKey = @"a6d819499131071f158fd740860a5a88";


#pragma mark - Properties

+ (FBFlickrAPI *)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static FBFlickrAPI *_sharedObject = nil;
    // Initialize once
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] initPrivate];
    });
    return _sharedObject;
}

- (NSDateFormatter *)formatter {
    static dispatch_once_t pred = 0;
    __strong static NSDateFormatter *_formatter = nil;
    // Initialize once
    dispatch_once(&pred, ^{
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return _formatter;
}

- (NSURL *)interestingPhotosURL {
    return [[FBFlickrAPI sharedInstance] flickrURL:@"flickr.interestingness.getList" parameters:@{@"extras": @"url_h,date_taken"}];
}

#pragma mark - Initializers

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        // Setup
    }
    return self;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use sharedInstance" userInfo:nil];
    return nil;
}


#pragma mark - Methods

// Public
- (void)photoObjectsFromJson:(NSData *)data completionHandler:(void (^)(NSArray *, NSError *))completion {
    // Pass error by reference to save error at given mem address
    NSError *error;
    NSDictionary *jsonFoundationObject = [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingMutableContainers
                                      error:&error];
    
    // Check if serializaion succeeded
    if (error == nil) {
        NSDictionary *photosJSONDict = jsonFoundationObject[@"photos"];
        NSArray *photosJSONArray = photosJSONDict[@"photo"];
        
        NSMutableArray *photoObjects = [[NSMutableArray alloc] init];
        for (NSDictionary *object in photosJSONArray) {
            if (object[@"url_h"]){
                FBPhoto *photo = [self photoFrom:object];
                if (photo) {
                    [photoObjects addObject:photo];
                } else {
                    NSLog(@"photoObjectsFromJson error");
                }
            }
            
        }
        if ([photoObjects count] == 0 && [photosJSONArray count] != 0) {
            // We weren't able to parse any of the photos.
            // Maybe the JSON format for photos has changed.
            NSLog(@"[photoObjects count] == 0 && [photosJSONArray count] != 0");
        }
        completion(photoObjects, nil);
    } else {
        completion(nil, error);
    }
}


// Private

// Parse individual photo object
- (FBPhoto *)photoFrom:(NSDictionary *)jsonDict {
    NSDate *date = [[self formatter] dateFromString:jsonDict[@"datetaken"]];
    NSString *title = jsonDict[@"title"];
    NSString *photoID = jsonDict[@"id"];
    NSString *urlString = jsonDict[@"url_h"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    FBPhoto *photo = [[FBPhoto alloc] initWithTitle:title photoID:photoID dateTaken:date remoteURL:url];
    // Return photo object if parsing succeeds
    if (photo) {
        return photo;
    } else {
        NSLog(@"Parsing photo object for title: %@, failed", title);
        return nil;
    }
}


// Flickr NSURL constructor
- (NSURL *)flickrURL:(NSString *)method parameters:(NSDictionary *)extraParams {
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:baseURLString];
    NSMutableArray *queryItems = [[NSMutableArray alloc] init];
    
    // base params for every flickr method
    NSDictionary *baseParams = @{ @"method": method,
                                  @"format": @"json",
                                  @"nojsoncallback": @"1",
                                  @"api_key": apiKey };
    [baseParams enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSURLQueryItem *item = [[NSURLQueryItem alloc] initWithName:key value:value];
        [queryItems addObject:item];
    }];
    
    // Additional params specific to certain method
    if (extraParams) {
        [extraParams enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
            NSURLQueryItem *item = [[NSURLQueryItem alloc] initWithName:key value:value];
            [queryItems addObject:item];
        }];
    }
    
    // Return constructed url
    components.queryItems = queryItems;
    return components.URL;
}



@end
