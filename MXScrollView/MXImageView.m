//
//  MXImageView.m
//  MXScrollViewDemo
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 PRO. All rights reserved.
//

#import "MXImageView.h"
#import "UIImageView+CMWebCache.h"

@implementation MXImageView

- (instancetype)initWithFrame:(CGRect)frame
                         hasTable:(BOOL)hasTable {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = hasTable ? UIViewContentModeScaleAspectFill : UIViewContentModeScaleToFill;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(tapImageView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setImageWithSource:(id)imageSource
          placeholderImage:(UIImage *)placeholderImage {
    if ([imageSource isKindOfClass:[UIImage class]]) {
        self.image = (UIImage *)imageSource;
    } else if ([imageSource isKindOfClass:[NSString class]]) {
        [self CMSD_setImageWithURL:[NSURL URLWithString:(NSString *)imageSource]
                  placeholderImage:placeholderImage];
    }

}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    if (self.didTapImageViewHandle) {
        self.didTapImageViewHandle();
    }
}

@end
