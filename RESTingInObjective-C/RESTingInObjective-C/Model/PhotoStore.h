//
//  PhotoStore.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 02/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBFlickrAPI;

@interface PhotoStore : NSObject


#pragma mark: - Methods

- (void)fetchInterestingPhotos;

@end
