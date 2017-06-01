//
//  FBFlickrAPI.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFlickrAPI : NSObject

+ (FBFlickrAPI *)sharedInstance;
- (NSURL *)interestingPhotosURL;
- (void)photoObjectsFromJson:(NSData *)data
                  completion:(void (^)(NSDictionary*,NSError*))callback;
@property (nonatomic, readonly) NSURL *interestingPhotosURL;
@end
