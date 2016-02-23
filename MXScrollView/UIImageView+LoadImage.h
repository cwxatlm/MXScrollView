//
//  UIImageView+LoadImage.h
//  MXScrollViewDemo
//
//  Created by PRO on 16/2/23.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadImage)

- (void)cm_downloadImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

@end
