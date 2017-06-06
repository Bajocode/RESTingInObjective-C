//
//  FBImageStore.m
//  RESTingInObjective-C
//
//  Created by Fabijan Bajo on 06/06/2017.
//  Copyright © 2017 Fabijan Bajo. All rights reserved.
//

#import "FBImageStore.h"

@interface FBImageStore ()

@property (nonatomic,copy) NSCache *cache;

@end

@implementation FBImageStore


#pragma mark - Methods

// Retrieve Image: cache? -> disk? -> set new
- (UIImage *)imageForKey:(NSString *)key {
    UIImage *imageFromCache = [self.cache objectForKey:key];
    // If in cache, return
    if (imageFromCache) {
        return imageFromCache;
    } else {
        // Get url and check disk
        NSURL *url = [self imageURLForKey:key];
        UIImage *imageFromDisk = [UIImage imageWithContentsOfFile:url.path];
        if (imageFromDisk) {
            [self.cache setObject:imageFromDisk forKey:key];
            return imageFromDisk;
        } else {
            return nil;
        }
    }
}

// Set image
- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    [self.cache setObject:image forKey:key];
    // Create full URL for image
    NSURL *url = [self imageURLForKey:key];
    
    // To JPEG and then to filestorage
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    if (data) {
        [data writeToURL:url atomically:YES];
    }
}

- (void)deleteImageForKey:(NSString *)key {
    // Remove from cache
    [self.cache removeObjectForKey:key];
    // Remove from file system
    NSURL *url = [self imageURLForKey:key];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
    if (error) {
        NSLog(@"Image deleted from disk error: %@", error);
    }
}


// Helper for generating filestorage urls based on photo key
- (NSURL *)imageURLForKey:(NSString *)key {
    NSArray *docsDirs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *docsDir = [docsDirs firstObject];
    return [docsDir URLByAppendingPathComponent:key];
}





@end
