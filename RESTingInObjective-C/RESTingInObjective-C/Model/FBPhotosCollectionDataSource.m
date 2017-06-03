//
//  FBPhotosCollectionDataSource.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBPhotosCollectionDataSource.h"
#import "FBPhotoCollectionViewCell.h"

NSString *const cellID = @"PhotoCell";
@interface FBPhotosCollectionDataSource ()

@end

@implementation FBPhotosCollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

@end
