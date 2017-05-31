//
//  FlickrAPI.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 30/05/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FlickrAPI.h"


@implementation FlickrAPI

#pragma mark - Constants

NSString *const baseURLString = @"https://api.flickr.com/services/rest";
NSString *const apiKey = @"a6d819499131071f158fd740860a5a88";


#pragma mark - Properties

+ (FlickrAPI *)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static FlickrAPI *_sharedObject = nil;
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
        _formatter.dateFormat = @"";
    });
    return _formatter;
}

- (NSURL *)interestingPhotosURL {
    return [[FlickrAPI sharedInstance] flickrURL:@"flickr.interestingness.getList" parameters:@{@"extras": @"url_h,date_taken"}];
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

// Private
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
