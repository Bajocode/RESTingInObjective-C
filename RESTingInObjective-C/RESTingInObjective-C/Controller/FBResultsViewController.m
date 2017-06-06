//
//  FBResultsViewController.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBResultsViewController.h"
#import "FBPhotoStore.h"
#import "FBPhotoCollectionViewCell.h"
#import "FBPhotosCollectionDataSource.h"

NSString *const cellId = @"PhotoCell";
@interface FBResultsViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic) FBPhotosCollectionDataSource *dataSource;

@end

@implementation FBResultsViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
    [self fetchInterestingPhotos];
}


#pragma mark - Methods

- (void)configure {
    self.navigationItem.title = @"Interesting Photos";
    // CollectionView
    self.collectionView.delegate = self;
    self.dataSource = [[FBPhotosCollectionDataSource alloc] initWithPhotoStore:[[FBPhotoStore alloc]init]];
    self.collectionView.dataSource = self.dataSource;
    UINib *cellNib = [UINib nibWithNibName:@"FBPhotoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:cellId];
}

- (void)fetchInterestingPhotos {
    [self.dataSource.photoStore fetchInterestingPhotosWithCompletionHandler:^(NSArray *photos, NSError *error) {
        if (error == nil) {
            self.dataSource.photos = photos;
        } else {
            NSLog(@"%@", error);
        }
        [self.collectionView reloadSections:[[NSIndexSet alloc] initWithIndex:0]];
    }];
}


#pragma mark: - CollectionView Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.view.bounds.size.width - 1) / 2;
    return CGSizeMake(width, width*1.5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

@end
