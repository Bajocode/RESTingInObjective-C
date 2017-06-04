//
//  FBPhotosCollectionDataSource.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBPhotosCollectionDataSource.h"
#import "FBPhotoCollectionViewCell.h"
#import "FBPhotoStore.h"


NSString *const cellID = @"PhotoCell";
@interface FBPhotosCollectionDataSource ()

@end

@implementation FBPhotosCollectionDataSource


#pragma mark - Initializers

- (instancetype)initWithPhotoStore:(FBPhotoStore *)store {
    // Call super designated
    self = [super init];
    
    // If super init succeeds
    if (self) {
        _photoStore = store;
    }
    return self;
}


#pragma mark: - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    FBPhoto *photo = self.photos[indexPath.row];
    
    [self.photoStore fetchImageForPhoto:photo completionHandler:^(UIImage *image, NSError *error) {
        [cell updateWithImage:image];
    }];
    
    return cell;
}

@end
