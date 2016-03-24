/*
 * This file is part of the CMSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <UIKit/UIKit.h>
#import "CMSDWebImageCompat.h"
#import "CMSDWebImageManager.h"

/**
 * Integrates CMSDWebImage async downloading and caching of remote images with UIImageView for highlighted state.
 */
@interface UIImageView (CMHighlightedWebCache)

/**
 * Set the imageView `highlightedImage` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url The url for the image.
 */
- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url;

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url     The url for the image.
 * @param options The options to use when downloading the image. @see CMSDWebImageOptions for the possible values.
 */
- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options;

/**
 * Set the imageView `highlightedImage` with an `url`.
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
- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletionBlock)completedBlock;

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see CMSDWebImageOptions for the possible values.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletionBlock)completedBlock;

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see CMSDWebImageOptions for the possible values.
 * @param progressBlock  A block called while image is downloading
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)CMSD_setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options progress:(CMSDWebImageDownloaderProgressBlock)progressBlock completed:(CMSDWebImageCompletionBlock)completedBlock;

/**
 * Cancel the current download
 */
- (void)CMSD_cancelCurrentHighlightedImageLoad;

@end


@interface UIImageView (HighlightedWebCacheDeprecated)

- (void)setHighlightedImageWithURL:(NSURL *)url __deprecated_msg("Method deprecated. Use `CMSD_setHighlightedImageWithURL:`");
- (void)setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options __deprecated_msg("Method deprecated. Use `CMSD_setHighlightedImageWithURL:options:`");
- (void)setHighlightedImageWithURL:(NSURL *)url completed:(CMSDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `CMSD_setHighlightedImageWithURL:completed:`");
- (void)setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options completed:(CMSDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `CMSD_setHighlightedImageWithURL:options:completed:`");
- (void)setHighlightedImageWithURL:(NSURL *)url options:(CMSDWebImageOptions)options progress:(CMSDWebImageDownloaderProgressBlock)progressBlock completed:(CMSDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `CMSD_setHighlightedImageWithURL:options:progress:completed:`");

- (void)cancelCurrentHighlightedImageLoad __deprecated_msg("Use `CMSD_cancelCurrentHighlightedImageLoad`");

@end
