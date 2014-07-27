//
//  detail.h
//  flipertest
//
//  Created by CooLX on 16/07/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detail : UIViewController
-(void)didSwipe:(UISwipeGestureRecognizer*)swipe;
@property (weak, nonatomic) IBOutlet UIWebView *web;

@property NSUInteger currindex;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;
@end
