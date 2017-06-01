//
//  FBPhoto.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBPhoto.h"

@implementation FBPhoto


#pragma mark - Initializers

- (instancetype)initWithTitle:(NSString *)title photoID:(NSString *)photoID dateTaken:(NSDate *)date remoteURL:(NSURL *)url {
    return [self initWithTitle:title
                       photoID:photoID
                     dateTaken:date
                     remoteURL:url];
}


#pragma mark - Methods


@end
