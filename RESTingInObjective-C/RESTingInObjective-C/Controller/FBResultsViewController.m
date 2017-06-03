//
//  FBResultsViewController.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBResultsViewController.h"
#import "FBPhotoStore.h"

@interface FBResultsViewController ()

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

@end
