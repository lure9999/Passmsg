//
//  FlickTabButton.m
//  Enormego Frameworks
//
//  Created by Shaun Harrison on 12/12/08.
//  Copyright 2008 enormego. All rights reserved.
//

#import "FlickTabButton.h"

#define unselectedColor [UIColor colorWithRed:78/255.0f green:86/255.0f blue:92/255.0f alpha:1.0f]
#define unselectedShadowColor [UIColor colorWithWhite:1.0f alpha:0.7f]
#define selectedColor [UIColor whiteColor]

@implementation FlickTabButton

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        if (image) {
            [self setBackgroundImage:image
                            forState:UIControlStateNormal];
        }
        [self setTitleColor:unselectedColor forState:UIControlStateNormal];
//        [self setTitleShadowColor:unselectedColor forState:UIControlStateNormal];
        [self setTitleColor:selectedColor forState:UIControlStateSelected];
//        self.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		imageView.backgroundColor = [UIColor clearColor];
		imageView.hidden = YES;
		imageView.contentMode = UIViewContentModeScaleToFill;
        self.selectedImageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}


//- (void)drawRect:(CGRect)rect {
    // Drawing code
//}

- (void)setText:(NSString*)text {
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitle:text forState:UIControlStateSelected];
}

- (void)markSelected {
    self.selectedImageView.hidden = NO;
	self.selected = YES;
}

- (void)markUnselected {
    self.selectedImageView.hidden = YES;
	self.selected = NO;
}

- (NSString*)text {
	return self.titleLabel.text;
}

- (UIFont*)font {
	return self.titleLabel.font;
}



@end
