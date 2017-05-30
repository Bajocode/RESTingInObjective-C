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

const NSString *baseURLString = @"https://api.flickr.com/services/rest";
const NSString *apiKey = @"a6d819499131071f158fd740860a5a88";


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



@end
