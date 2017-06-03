//
//  FBPhotoStore.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBPhotoStore : NSObject


#pragma mark: - Methods

- (void)fetchInterestingPhotosWithCompletionHandler:(void (^)(NSArray*, NSError *))completion;

@end
