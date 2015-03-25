//
//  KGModal.m
//  KGModal
//
//  Created by David Keegan on 10/5/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "KGModal.h"
#import <QuartzCore/QuartzCore.h>

CGFloat const kFadeInAnimationDuration = 0.3;
CGFloat const kTransformPart1AnimationDuration = 0.2;
CGFloat const kTransformPart2AnimationDuration = 0.1;
NSString *const KGModalGradientViewTapped = @"KGModalGradientViewTapped";

@interface KGModalGradientView : UIView
@end

@interface KGModalContainerView : UIView
@end

@interface KGModalCloseButton : UIButton
@end

@interface KGModalViewController : UIViewController
@property (assign, nonatomic) KGModalGradientView *styleView;
@end

@interface KGModal()
@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) KGModalViewController *viewController;
@property (assign, nonatomic) KGModalContainerView *containerView;
@property (assign, nonatomic) KGModalCloseButton *closeButton;
@property (assign, nonatomic) UIView *contentView;
@end

@implementation KGModal

+ (id)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    if(!(self = [super init])){
        return nil;
    }
    self.window  = nil;
    self.tapOutsideToDismiss = YES;
    self.animateWhenDismissed = YES;
    self.showCloseButton = YES;

    return self;
}

- (void)setShowCloseButton:(BOOL)showCloseButton BgImage:(UIImage*)image{
//    if(_showCloseButton != showCloseButton){
//        _showCloseButton = showCloseButton;
        [self.closeButton setHidden:showCloseButton];
        [self.closeButton setBackgroundImage:image forState:UIControlStateNormal];
//    }
}


- (void)showWithContentView:(UIView *)contentView{
    [self showWithContentView:contentView andAnimated:YES];
}

- (void)showWithContentView:(UIView *)contentView andAnimated:(BOOL)animated{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;

    KGModalViewController *viewController = self.viewController = [[KGModalViewController alloc] init];
    self.window.rootViewController = viewController;

    CGFloat padding = 17;
    CGRect containerViewRect = CGRectInset(contentView.bounds, -padding, -padding);
    containerViewRect.origin.x = containerViewRect.origin.y = 0;
    containerViewRect.origin.x = round(CGRectGetMidX(self.window.bounds)-CGRectGetMidX(containerViewRect));
    containerViewRect.origin.y = round(CGRectGetMidY(self.window.bounds)-CGRectGetMidY(containerViewRect));
    KGModalContainerView *containerView = self.containerView = [[KGModalContainerView alloc] initWithFrame:containerViewRect];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    containerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    contentView.frame = (CGRect){padding, padding, contentView.bounds.size};
    [containerView addSubview:contentView];
    [viewController.view addSubview:containerView];

    KGModalCloseButton *closeButton = self.closeButton = [[KGModalCloseButton alloc] init];
    [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setHidden:!self.showCloseButton];
    [containerView addSubview:closeButton];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapCloseAction:)
                                                 name:KGModalGradientViewTapped object:nil];

    // The window has to be un-hidden on the main thread
    // This will cause the window to display
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window setHidden:NO];
        
        if(animated){
            viewController.styleView.alpha = 0;
            [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
                viewController.styleView.alpha = 1;
            }];

            containerView.alpha = 0;
            containerView.layer.shouldRasterize = YES;
            containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
                containerView.alpha = 1;
                containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    containerView.alpha = 1;
                    containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                } completion:^(BOOL finished2) {
                    containerView.layer.shouldRasterize = NO;
                }];
            }];
        }
    });
}

- (void)closeAction:(id)sender{
    [self hideAnimated:self.animateWhenDismissed];
}

- (void)tapCloseAction:(id)sender{
    if(self.tapOutsideToDismiss){
        [self hideAnimated:self.animateWhenDismissed];
    }
}

- (void)hide{
    [self hideAnimated:YES];
}

-(BOOL)iSHiden{
    if (self.window) {
        if (![self.window isHidden]) {
            return NO;
        }else{
            return YES;
        }
    }else
        return YES;
}

- (void)hideAnimated:(BOOL)animated{
    if(!animated){
        [self cleanup];
        return;
    }
    [self.window setHidden:YES];

    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
            self.viewController.styleView.alpha = 0;
        }];

        self.containerView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:kTransformPart2AnimationDuration animations:^{
            self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.containerView.alpha = 0;
                self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2){
                [self cleanup];
            }];
        }];
    });
}

- (void)cleanup{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.containerView removeFromSuperview];
    [self.window removeFromSuperview];
    self.window = nil;
}

@end

@implementation KGModalViewController

- (void)loadView{
    UIView *v = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = v;
    [v release];
}

- (void)viewDidLoad{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    KGModalGradientView *styleView = self.styleView = [[KGModalGradientView alloc] initWithFrame:self.view.bounds];
    styleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    styleView.opaque = NO;
    [self.view addSubview:styleView];
    [styleView release];
}

@end

@implementation KGModalContainerView

- (id)initWithFrame:(CGRect)frame{
    if(!(self = [super initWithFrame:frame])){
        return nil;
    }

//    CALayer *styleLayer = [[CALayer alloc] init];
//    styleLayer.cornerRadius = 4;
//    styleLayer.shadowColor= [[UIColor whiteColor] CGColor];
//    styleLayer.shadowOffset = CGSizeMake(0, 0);
//    styleLayer.shadowOpacity = 0.5;
//    styleLayer.borderWidth = 1;
//    styleLayer.borderColor = [[UIColor whiteColor] CGColor];
//    styleLayer.backgroundColor = [[UIColor colorWithWhite:0 alpha:0.55] CGColor];
//    styleLayer.frame = CGRectInset(self.bounds, 12, 12);
//    [self.layer addSublayer:styleLayer];
    
    return self;
}

@end

@implementation KGModalGradientView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //[[NSNotificationCenter defaultCenter] postNotificationName:KGModalGradientViewTapped object:nil];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if([[KGModal sharedInstance] backgroundDisplayStyle] == KGModalBackgroundDisplayStyleSolid){
        [[UIColor colorWithWhite:0 alpha:0.55] set];
        CGContextFillRect(context, self.bounds);
    }else{
        CGContextSaveGState(context);
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0, 0, 0, 0.3, 0, 0, 0, 0.8};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace), colorSpace = NULL;
        CGPoint gradCenter= CGPointMake(round(CGRectGetMidX(self.bounds)), round(CGRectGetMidY(self.bounds)));
        CGFloat gradRadius = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        CGContextDrawRadialGradient(context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient), gradient = NULL;
        CGContextRestoreGState(context);
    }
}

@end

@implementation KGModalCloseButton

- (id)init{
    if(!(self = [super initWithFrame:(CGRect){250, 10, 25, 25}])){
        return nil;
    }
//    static UIImage *closeButtonImage;
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        closeButtonImage = [self closeButtonImage];
//    });
    [self setBackgroundImage:[UIImage imageNamed:@"x.png"] forState:UIControlStateNormal];
    return self;
}
@end
