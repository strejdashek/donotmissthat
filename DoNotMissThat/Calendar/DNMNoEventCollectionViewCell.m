//
//  DNMNoEventCollectionViewCell.m
//  DoNotMissIt
//
//  Created by Viktor Kucera on 9/5/14.
//  Copyright (c) 2014 Viktor Kucera. All rights reserved.
//

#import "DNMNoEventCollectionViewCell.h"

@implementation DNMNoEventCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIImage *)rasterizedImageCopy
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
