//
//  FBPhoto.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 01/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBPhoto : NSObject


#pragma mark: - Properties

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *photoID;
@property (nonatomic) NSDate *dateTaken;
@property (nonatomic) NSURL *remoteURL;


#pragma mark: - Initializers

// Designated 
- (instancetype)initWithTitle:(NSString *)title
                      photoID:(NSString *)photoID
                    dateTaken:(NSDate *)date
                    remoteURL:(NSURL *)url;
@end

