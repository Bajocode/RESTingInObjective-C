//
//  FBPhotosCollectionDataSource.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBPhotoStore;

extern NSString *const cellID;
@interface FBPhotosCollectionDataSource : NSObject <UICollectionViewDataSource>

#pragma mark: - Properties

@property (nonatomic, copy)NSArray *photos;
@property(nonatomic)FBPhotoStore *photoStore;


#pragma mark: - Initializers

- (instancetype)initWithPhotoStore:(FBPhotoStore *)store;

@end
