//
//  PAStepper.m
//  Leroy Merlin
//
//  Created by Miroslav Perovic on 11/30/12.
//  Copyright (c) 2012 Pure Agency. All rights reserved.
//

#import "PAStepper.h"
#import "OneOrderEditorView.h"
#define COUNTLABELTAG             100000001
@interface PAStepper () {
	UIImageView *backgroundImageView;
	UIButton *incrementButton;
	UIButton *decrementButton;
	UILabel *label;
	
	UIImage *normalStateImage;
	UIImage *selectedStateImage;
	UIImage *highlightedStateImage;
	UIImage *disabledStateImage;
	
	NSNumber *changingValue;
}

@end

@implementation PAStepper
@synthesize mController;
- (void)awakeFromNib
{
	[self setInitialValues];
}

- (id)initWithFrame:(CGRect)frame
{
    /*
	if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 116.0, 29.0)]) {
		[self setInitialValues];
	}
    */
    
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 120, 37)]) {
        [self setInitialValues];
    }
	
	return self;
}

- (void)setInitialValues
{
	_tintColor = [UIColor whiteColor];
	_textColor = [UIColor blackColor];
	_value = 0;
	_continuous = YES;
	_minimumValue = 0;
	_maximumValue = 1000000;
	_stepValue = 1;
	_wraps = NO;
	_autorepeat = YES;
	_autorepeatInterval = 0.5;
	label.textColor = _textColor;
	
	// init left button
	decrementButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 40, 37)];
	[decrementButton setImage:[UIImage imageNamed:@"subtract.png"] forState:UIControlStateNormal];
	[decrementButton setTintColor:_tintColor];
	[decrementButton setAutoresizingMask:UIViewAutoresizingNone];
    [decrementButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [decrementButton addTarget:self action:@selector(didBeginLongTap:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [decrementButton addTarget:self action:@selector(didEndLongTap) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragExit];
	[self addSubview:decrementButton];
	
	// background image
	backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0.0, 40, 37)];
	normalStateImage = [UIImage imageNamed:@"number.png"];
	[backgroundImageView setImage:normalStateImage];
	[self addSubview:backgroundImageView];
	
	// label
	label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, 40, 37)];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setFont:[UIFont systemFontOfSize:15.0]];
	[label setTextColor:_textColor];
	[self setLabelText];
	[backgroundImageView addSubview:label];
	
	// init right button
	incrementButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 0.0, 40, 37)];
	[incrementButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
	[incrementButton setTintColor:_tintColor];
    [incrementButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [incrementButton addTarget:self action:@selector(didBeginLongTap:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [incrementButton addTarget:self action:@selector(didEndLongTap) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragExit];
	[self addSubview:incrementButton];
}

- (void)setFrame:(CGRect)frame
{
	// don't allow to change frame
	[super setFrame:CGRectMake(frame.origin.x, frame.origin.y, 116.0, 29.0)];
}

- (void)setLabelText
{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
	[formatter setNumberStyle:NSNumberFormatterNoStyle];
	[label setText:[formatter stringFromNumber:[NSNumber numberWithDouble:_value]]];
}


#pragma mark - Set Values
- (void)setMinimumValue:(double)minValue
{
	if (minValue > _maximumValue) {
		NSException *ex = [NSException exceptionWithName:NSInvalidArgumentException
												  reason:@"Invalid minimumValue"
												userInfo:nil];
		@throw ex;
	}
}

- (void)setStepValue:(double)stepValue
{
	if (stepValue <= 0) {
		NSException *ex = [NSException exceptionWithName:NSInvalidArgumentException
												  reason:@"Invalid stepValue"
												userInfo:nil];
		@throw ex;
	}
}

- (void)setMaximumValue:(double)maxValue
{
	if (maxValue < _minimumValue) {
		NSException *ex = [NSException exceptionWithName:NSInvalidArgumentException
												  reason:@"Invalid maximumValue"
												userInfo:nil];
		@throw ex;
	}
}

- (void)setValue:(double)val
{
	if (val < _minimumValue) {
		val = _minimumValue;
	} else if (val > _maximumValue) {
		val = _maximumValue;
	}
	_value = val;
	
	if (_value == val) {
		[self sendActionsForControlEvents:UIControlEventValueChanged];
		[self setLabelText];
	}
}

- (void)setAutorepeatValue:(double)autorepeatInterval
{
	if (autorepeatInterval > 0.0) {
		_autorepeatInterval = autorepeatInterval;
	} else if (autorepeatInterval == 0) {
		_autorepeatInterval = autorepeatInterval;
		_autorepeat = NO;
	}
}


# pragma mark - Public Methods

- (UIImage *)backgroundImageForState:(UIControlState)state
{
	switch (state) {
		case UIControlStateNormal:
			return normalStateImage;
			break;
			
		case UIControlStateHighlighted:
			if (highlightedStateImage) {
				return highlightedStateImage;
			} else {
				return normalStateImage;
			}
			break;
			
		case UIControlStateDisabled:
			if (disabledStateImage) {
				return disabledStateImage;
			} else {
				return normalStateImage;
			}
			break;
			
		case UIControlStateSelected:
			if (selectedStateImage) {
				return selectedStateImage;
			} else {
				return normalStateImage;
			}
			break;
			
		default:
			return normalStateImage;
			break;
	}
	
	return normalStateImage;
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
{
	switch (state) {
		case UIControlStateNormal:
			normalStateImage = image;
			break;
			
		case UIControlStateHighlighted:
			highlightedStateImage = image;
			break;
			
		case UIControlStateDisabled:
			disabledStateImage = image;
			break;
			
		case UIControlStateSelected:
			selectedStateImage = image;
			break;
			
		default:
			break;
	}
}

- (UIImage *)decrementImageForState:(UIControlState)state
{
	return [decrementButton imageForState:state];
}

- (void)setdDecrementImage:(UIImage *)image forState:(UIControlState)state
{
	[decrementButton setImage:image forState:state];
}

- (void)setdDecrementUneable{
    decrementButton.enabled = NO;
}

- (void)setincrementUneable{
    incrementButton.enabled = NO;
}

- (UIImage *)incrementImageForState:(UIControlState)state
{
	return [incrementButton imageForState:state];
}

- (void)setdIncrementImage:(UIImage *)image forState:(UIControlState)state
{
	[incrementButton setImage:image forState:state];
}

#pragma mark - Actions

- (void)didPressButton:(id)sender
{
	[self setHighlighted:YES];
	if (changingValue) {
		return;
	}
	
	UIButton *button = (UIButton *)sender;
	double changeValue;
	if (button == decrementButton) {
		changeValue = -1 * _stepValue;
	} else {
		changeValue = _stepValue;
	}
	changingValue = [NSNumber numberWithDouble:changeValue];
	[self performSelector:@selector(changeValue:) withObject:changingValue afterDelay:0.5];
}

- (void)didBeginLongTap:(id)sender
{
	[self setHighlighted:YES];
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	UIButton *button = (UIButton *)sender;
	double changeValue;
	if (button == decrementButton) {
		changeValue = -1 * _stepValue;
	} else {
		changeValue = _stepValue;
	}
	changingValue = [NSNumber numberWithDouble:changeValue];
	if (_continuous) {
		[self changeValue:changingValue];
	}
	[self performSelector:@selector(longTapLoop) withObject:nil afterDelay:_autorepeatInterval];
}

- (void)didEndLongTap
{
	[self setHighlighted:NO];

	if (!_continuous) {
		[self performSelectorOnMainThread:@selector(changeValue:) withObject:changingValue waitUntilDone:YES];
	}

	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	changingValue = nil;
}

- (void)longTapLoop
{
	if (_autorepeat) {
		[self performSelector:@selector(longTapLoop) withObject:nil afterDelay:_autorepeatInterval];
		[self performSelectorOnMainThread:@selector(changeValue:) withObject:changingValue waitUntilDone:YES];
	}
}


#pragma mark - Overwrite UIControl methods

- (void)setEnabled:(BOOL)enabled
{
	if (enabled) {
		backgroundImageView.image = normalStateImage;
	} else {
		if (disabledStateImage) {
			backgroundImageView.image = disabledStateImage;
		}
	}
}

- (void)setHighlighted:(BOOL)highlighted
{
	if (highlighted && highlightedStateImage) {
		backgroundImageView.image = highlightedStateImage;
	} else {
		backgroundImageView.image = normalStateImage;
	}
}

- (void)setSelected:(BOOL)selected
{
	if (selected && selectedStateImage) {
		backgroundImageView.image = selectedStateImage;
	} else {
		backgroundImageView.image = normalStateImage;
	}
}


#pragma mark - Other methods
- (void)changeValue:(NSNumber *)change
{
	double toChange = [change doubleValue];
	double newValue = _value + toChange;
	if (toChange < 0) {
		if (newValue < _minimumValue) {
			if (!_wraps) {
				return;
			} else {
				newValue = _maximumValue;
			}
		}
	} else {
		if (newValue > _maximumValue) {
			if (!_wraps) {
				return;
			} else {
				newValue = _minimumValue;
			}
		}
	}
	[self setValue:newValue];
    if ([mController isKindOfClass:[OneOrderEditorView class]]) {
        UILabel *countLabel =(UILabel *)[mController viewWithTag:COUNTLABELTAG];
        int count =newValue;
        
        OneOrderEditorView  *vc =(OneOrderEditorView *)mController;
        
        if (count == 0) {
            count = count +1;
            [self setValue:newValue+1];
            decrementButton.enabled = NO;
            [decrementButton setImage:[UIImage imageNamed:@"subtract_gray.png"] forState:UIControlStateNormal];
        }if (count == 1) {
            decrementButton.enabled = NO;
            [decrementButton setImage:[UIImage imageNamed:@"subtract_gray.png"] forState:UIControlStateNormal];
        }
        else{
            decrementButton.enabled = YES;
            [decrementButton setImage:[UIImage imageNamed:@"subtract.png"] forState:UIControlStateNormal];
        
        }
        
        if (count == [vc.tempGoodEntity.stock_num integerValue]) {
//            [[iToast makeText:@"商品库存数不足"] show];
            incrementButton.enabled = NO;
            [incrementButton setImage:[UIImage imageNamed:@"add_gray.png"] forState:UIControlStateNormal];
//            [self setValue:newValue-1];
//            return;
        }else
        {
            [incrementButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
            incrementButton.enabled = YES;
        }
        
        [(OneOrderEditorView *)mController change:[NSString stringWithFormat:@"%d",count]];
        countLabel.text =[NSString stringWithFormat:@"x%d",count];
    }
}

@end
