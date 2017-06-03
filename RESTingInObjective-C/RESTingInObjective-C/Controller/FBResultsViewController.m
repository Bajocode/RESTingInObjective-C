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
    // CollectionView
    self.collectionView.delegate = self;
    self.dataSource = [[FBPhotosCollectionDataSource alloc] init];
    self.collectionView.dataSource = self.dataSource;
    [self.collectionView registerClass:[FBPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCell"];
}

- (void)fetchInterestingPhotos {
    [[self photoStore] fetchInterestingPhotosWithCompletionHandler:^(NSArray *photos, NSError *error) {
        if (error == nil) {
            [self.dataSource.photos addObjectsFromArray:photos];
        } else {
            NSLog(@"%@", error);
        }
        [self.collectionView reloadSections:[[NSIndexSet alloc] initWithIndex:0]];
    }];
}

#pragma mark: - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
