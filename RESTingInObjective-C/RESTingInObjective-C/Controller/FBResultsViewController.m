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

@interface FBResultsViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic)

@end

@implementation FBResultsViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self photoStore] fetchInterestingPhotosWithCompletionHandler:^(NSArray *photos, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%lu", (unsigned long)[photos count]);
        }
        
    }];
}

#pragma mark - Methods

- (void)configure {
    // CollectionView
    [self.collectionView registerClass:[FBPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCell"];
}


#pragma mark: - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return
}

@end
