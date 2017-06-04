//
//  FBPhotoCollectionViewCell.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 03/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBPhotoCollectionViewCell.h"

@interface FBPhotoCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UIImageView *thumbImageView;

@end

@implementation FBPhotoCollectionViewCell


#pragma mark: - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateWithImage:nil];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    [self updateWithImage:nil];
}


#pragma mark: - Methods

- (void) updateWithImage:(UIImage*)image {
    NSLog(@"%@", image);
    if (image) {
        [self.spinner stopAnimating];
        self.thumbImageView.image = image;
    } else {
        [self.spinner startAnimating];
        self.thumbImageView.image = nil;
    }
}

@end
