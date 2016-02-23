//
//  UIImageView+LoadImage.m
//  MXScrollViewDemo
//
//  Created by PRO on 16/2/23.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "UIImageView+LoadImage.h"

@implementation UIImageView (LoadImage)

- (void)cm_downloadImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
    if (placeholderImage) {
        self.image = placeholderImage;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error = %@", error.description);
        }
        UIImage *downloadImage = [UIImage imageWithData:data];
        self.image = downloadImage;
    }];
    [task resume];
}

@end
