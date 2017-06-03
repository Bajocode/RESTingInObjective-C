//
//  FBPhotosCollectionDataSource.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBPhotosCollectionDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, copy)NSMutableArray *photos;

@end
