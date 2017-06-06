//
//  FBImageStore.h
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 06/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBImageStore : NSObject

#pragma mark: - Methods

- (UIImage *)imageForKey:(NSString *)key;
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
