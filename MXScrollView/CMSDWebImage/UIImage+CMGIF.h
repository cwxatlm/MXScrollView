//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CMGIF)

+ (UIImage *)CMSD_animatedGIFNamed:(NSString *)name;

+ (UIImage *)CMSD_animatedGIFWithData:(NSData *)data;

- (UIImage *)CMSD_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
