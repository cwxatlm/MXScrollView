//
//  MKAnnotationView+WebCache.h
//  CMSDWebImage
//
//  Created by Olivier Poitrey on 14/03/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "CMSDWebImageManager.h"

/**
 * Integrates CMSDWebImage async downloading and caching of remote images with MKAnnotationView.
 */
@interface MKAnnotationView (CMWebCache)

/**
 * Get the current image URL.
 *
 * Note that because of the limitations of categories this property can get out of sync
 * if you use CMSD_setImage: directly.
 */
- (NSURL *)CMSD_imageURL;

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url The url for the image.
 */
- (void)CMSD_setImageWithURL:(NSURL *)url;

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see CMSD_setImageWithURL:placeholderImage:options:
 */
- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

/**
 * Set the imageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param options     The options to use when downloading the image. @see CMSDWebImageOptions for the possible values.
 */

- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options;

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)CMSD_setImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletionBlock)completedBlock;

/**
 * Set the imageView `image` with an `url`, placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(CMSDWebImageCompletionBlock)completedBlock;

/**
 * Set the imageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param placeholder    The image to be set initially, until the image request finishes.
 * @param options        The options to use when downloading the image. @see CMSDWebImageOptions for the possible values.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)CMSD_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletionBlock)completedBlock;

/**
 * Cancel the current download
 */
- (void)CMSD_cancelCurrentImageLoad;

@end


@interface MKAnnotationView (WebCacheDeprecated)

- (NSURL *)imageURL __deprecated_msg("Use `CMSD_imageURL`");

- (void)setImageWithURL:(NSURL *)url __deprecated_msg("Method deprecated. Use `CMSD_setImageWithURL:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder __deprecated_msg("Method deprecated. Use `CMSD_setImageWithURL:placeholderImage:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options __deprecated_msg("Method deprecated. Use `CMSD_setImageWithURL:placeholderImage:options:`");

- (void)setImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `CMSD_setImageWithURL:completed:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(CMSDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `CMSD_setImageWithURL:placeholderImage:completed:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `CMSD_setImageWithURL:placeholderImage:options:completed:`");

- (void)cancelCurrentImageLoad __deprecated_msg("Use `CMSD_cancelCurrentImageLoad`");

@end
