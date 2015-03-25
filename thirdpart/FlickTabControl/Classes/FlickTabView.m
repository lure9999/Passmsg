//
//  FlickTabView.m
//  FlickTabControl
//
//  Created by Shaun Harrison on 12/12/08.
//  Copyright 2008 enormego. All rights reserved.
//

#import "FlickTabView.h"
#import "FlickTabButton.h"

@interface FlickTabView (Private)
- (void)setupCaps;
@end


@implementation FlickTabView
@synthesize scrollView, leftCap, rightCap, delegate, dataSource, buttonInsets;
- (id)initWithFrame:(CGRect)frame;{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.scrollView.directionalLockEnabled = YES;
        self.scrollView.alwaysBounceVertical = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = YES;
        self.scrollView.delegate = self;
        self.scrollView.scrollsToTop = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}
- (void)awakeFromNib {
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
	self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	self.scrollView.directionalLockEnabled = YES;
	self.scrollView.alwaysBounceVertical = NO;
	self.scrollView.alwaysBounceHorizontal = YES;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.bounces = YES;
	self.scrollView.delegate = self;
    
	self.scrollView.scrollsToTop = NO;
	[self reloadData];
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)reloadData {
    NSInteger selectIndex = 0;
	if(scrollView.subviews && scrollView.subviews.count > 0) {
        selectIndex = [self selectedTabIndex];
		[scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
	
	if(!self.dataSource) {
		return;
	}
	
	long items = 0;
	
	if((items = [self.dataSource numberOfTabsInScrollTabView:self]) == 0) {
		return;
	}
	
	int x;
	
	for(x=0;x<items;x++) {
		NSString* str = [self.dataSource scrollTabView:self titleForTabAtIndex:x];
		
		FlickTabButton *button = [[FlickTabButton alloc] initWithFrame:CGRectZero withImage:nil];
		[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = scrollView.bounds.size.width / items;
        CGFloat high = scrollView.bounds.size.height;
        
		button.frame = CGRectMake(width * x, 0.0f, width+1, high);
		button.text = str;
        if ([self.dataSource respondsToSelector:@selector(scrollTabView:ButtonForTabAtIndex:)]) {
            button = [self.dataSource scrollTabView:button ButtonForTabAtIndex:x];
        }
		[scrollView addSubview:button];
	}
	
	scrollView.contentSize = CGSizeMake(320, 43.0f);
//    if(scrollView.subviews && scrollView.subviews.count > 0) {
//		[(FlickTabButton*)[scrollView.subviews objectAtIndex:0] markSelected];
//	}
    [self selectTabAtIndex:selectIndex];
    
	[self setupCaps];
}

- (void)buttonClicked:(FlickTabButton*)button {
	[scrollView.subviews makeObjectsPerformSelector:@selector(markUnselected)];
	[button markSelected];
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(scrollTabView:didSelectedTabAtIndex:)]) {
		[self.delegate scrollTabView:self didSelectedTabAtIndex:[scrollView.subviews indexOfObject:button]];
	}
}

- (void)selectTabAtIndex:(NSInteger)index {
	[self selectTabAtIndex:index animated:NO];
}

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
	if(!scrollView.subviews || scrollView.subviews.count < index+1) return;
	
	[scrollView.subviews makeObjectsPerformSelector:@selector(markUnselected)];
	[[scrollView.subviews objectAtIndex:index] markSelected];
	
	CGRect rect = ((UIButton*)[scrollView.subviews objectAtIndex:index]).frame;
	rect.size.width += 25.0f;
	
	[scrollView scrollRectToVisible:rect animated:animated];
	
	[self setupCaps];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(scrollTabView:didSelectedTabAtIndex:)]) {
		[self.delegate scrollTabView:self didSelectedTabAtIndex:index];
	}
    
}

- (void)updateOrientation {
	[self performSelector:@selector(setupCaps) withObject:nil afterDelay:0.3];
}

- (void)setupCaps {
	if(scrollView.contentSize.width <= scrollView.frame.size.width - scrollView.contentInset.left - scrollView.contentInset.right) {
		leftCap.hidden = YES;
		rightCap.hidden = YES;
	} else {
		if(scrollView.contentOffset.x > (-scrollView.contentInset.left)+10.0f) {
			leftCap.hidden = NO;
		} else {
			leftCap.hidden = YES;
		}
		
		if((scrollView.frame.size.width+scrollView.contentOffset.x)+10.0f >= scrollView.contentSize.width) {
			rightCap.hidden = YES;
		} else {
			rightCap.hidden = NO;
		}
	}
	
}

- (void)scrollViewDidScroll:(UIScrollView *)inScrollView {
	[self setupCaps];
}

- (NSInteger)selectedTabIndex {
	int x = 0;
	
	for(FlickTabButton* tab in scrollView.subviews) {
		if([tab isMemberOfClass:[FlickTabButton class]]) {
			if([tab isSelected]) return x;
		}
		
		x++;
	}
	
	return NSNotFound;
}

- (void)setButtonInsets:(UIEdgeInsets)insets {
	buttonInsets = UIEdgeInsetsMake(0.0f, insets.left, 0.0f, insets.right);
	self.scrollView.contentInset = buttonInsets;
}
- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


@end
