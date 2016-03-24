//
//  MXImageView.h
//  MXScrollViewDemo
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEnmuHeader.h"

@interface MXImageView : UIImageView

@property (nonatomic, copy) void (^didTapImageViewHandle)();

- (instancetype)initWithFrame:(CGRect)frame
                     hasTable:(BOOL)hasTable;

- (void)setImageWithSource:(id)imageSource
          placeholderImage:(UIImage *)placeholderImage;

@end
