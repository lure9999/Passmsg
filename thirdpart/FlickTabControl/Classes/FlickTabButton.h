//
//  FlickTabButton.h
//  FlickTabControl
//
//  Created by Shaun Harrison on 12/12/08.
//  Copyright 2008 enormego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickTabButton:UIButton
{
    
}
@property (nonatomic, strong) UIImageView *selectedImageView;
- (id)initWithFrame:(CGRect)frame withImage:(NSString *)image;

- (void)setText:(NSString*)text;

- (void)markSelected;
- (void)markUnselected;	

@end
