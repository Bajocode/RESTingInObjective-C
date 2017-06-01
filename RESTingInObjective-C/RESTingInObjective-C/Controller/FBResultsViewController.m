//
//  FBResultsViewController.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBResultsViewController.h"
#import "FBFlickrAPI.h"

@interface FBResultsViewController ()

@end

@implementation FBResultsViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // https://api.flickr.com/services/rest?nojsoncallback=1&method=flickr.interestingness.getList&api_key=a6d819499131071f158fd740860a5a88&format=json&extras=url_h,date_taken
    NSLog(@"URL: %@", [[FBFlickrAPI sharedInstance] interestingPhotosURL]);
}

@end
