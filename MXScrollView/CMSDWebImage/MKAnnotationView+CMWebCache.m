//
//  MKAnnotationView+WebCache.m
//  CMSDWebImage
//
//  Created by Olivier Poitrey on 14/03/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "MKAnnotationView+CMWebCache.h"
#import "objc/runtime.h"
#import "UIView+CMWebCacheOperation.h"

static char imageURLKey;

@implementation MKAnnotationView (CMWebCache)

- (NSURL *)CMSD_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)CMSD_setImageWithURL:(NSURL *)url {
    [self CMSD_setImageWithURL:url placeholderImage:nil options:0 completed:nil];
}

- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:0 completed:nil];
}

- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)CMSD_setImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletionBlock)completedBlock {
    [self CMSD_setImageWithURL:url placeholderImage:nil options:0 completed:completedBlock];
}

- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(CMSDWebImageCompletionBlock)completedBlock {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletionBlock)completedBlock {
    [self CMSD_cancelCurrentImageLoad];

    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = placeholder;

    if (url) {
        __weak __typeof(self)wself = self;
        id <CMSDWebImageOperation> operation = [CMSDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong MKAnnotationView *sself = wself;
                if (!sself) return;
                if (image) {
                    sself.image = image;
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self CMSD_setImageLoadOperation:operation forKey:@"MKAnnotationViewImage"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:CMSDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, CMSDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)CMSD_cancelCurrentImageLoad {
    [self CMSD_cancelImageLoadOperationWithKey:@"MKAnnotationViewImage"];
}

@end


@implementation MKAnnotationView (WebCacheDeprecated)

- (NSURL *)imageURL {
    return [self CMSD_imageURL];
}

- (void)setImageWithURL:(NSURL *)url {
    [self CMSD_setImageWithURL:url placeholderImage:nil options:0 completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:0 completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletedBlock)completedBlock {
    [self CMSD_setImageWithURL:url placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(CMSDWebImageCompletedBlock)completedBlock {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletedBlock)completedBlock {
    [self CMSD_setImageWithURL:url placeholderImage:placeholder options:options completed:^(UIImage *image, NSError *error, CMSDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)cancelCurrentImageLoad {
    [self CMSD_cancelCurrentImageLoad];
}

@end
