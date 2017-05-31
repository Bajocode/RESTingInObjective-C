//
//  ResultsViewController.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 29/05/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "ResultsViewController.h"
#import "FlickrAPI.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // https://api.flickr.com/services/rest?nojsoncallback=1&method=flickr.interestingness.getList&api_key=a6d819499131071f158fd740860a5a88&format=json&extras=url_h,date_taken
    NSLog(@"URL: %@", [[FlickrAPI sharedInstance] interestingPhotosURL]);
}





@end
