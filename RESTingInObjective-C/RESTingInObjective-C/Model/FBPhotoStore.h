//
//  FBPhotoStore.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBPhoto;

@interface FBPhotoStore : NSObject


#pragma mark: - Initializers

- (instancetype)init;


#pragma mark: - Methods

- (void)fetchInterestingPhotosWithCompletionHandler:(void (^)(NSArray*, NSError *))completion;
- (void)fetchImageForPhoto:(FBPhoto *)photo completionHandler:(void (^)(UIImage*, NSError *))completion;


@end
