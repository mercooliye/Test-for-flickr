//
//  detail.m
//  flipertest
//
//  Created by CooLX on 16/07/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import "detail.h"
#import "MySingleton.h"


@interface detail ()

@end

@implementation detail
@synthesize currindex;
@synthesize web;
#define photo [MySingleton sharedMySingleton].photo
#define index [MySingleton sharedMySingleton].index

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.progress startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.title=[NSString stringWithFormat:@"Фото № %d", currindex+1];
    [self.progress stopAnimating];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currindex=index.row;

    NSDictionary *tempy=[photo objectAtIndex:index.row];


    NSString *url_img=[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_c.jpg",[tempy valueForKey:@"farm"], [tempy valueForKey:@"server"],[tempy valueForKey:@"id"],[tempy valueForKey:@"secret"] ];

    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_img]]];


    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
if (currindex==photo.count-1)
            currindex=0;
        
else
            currindex++;
        
        
        NSDictionary *tempy=[photo objectAtIndex:currindex];
        NSString *url_img=[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_c.jpg",[tempy valueForKey:@"farm"], [tempy valueForKey:@"server"],[tempy valueForKey:@"id"],[tempy valueForKey:@"secret"] ];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_img]]];

        
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
if (currindex==0)
            currindex=photo.count-1;
        
else
        currindex--;

            
        
        NSDictionary *tempy=[photo  objectAtIndex:currindex];
        NSString *url_img=[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_c.jpg",[tempy valueForKey:@"farm"], [tempy valueForKey:@"server"],[tempy valueForKey:@"id"],[tempy valueForKey:@"secret"] ];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_img]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
