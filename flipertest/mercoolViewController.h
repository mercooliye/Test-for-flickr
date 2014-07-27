//
//  mercoolViewController.h
//  flipertest
//
//  Created by CooLX on 16/07/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mercoolViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) NSArray *ids;
@property (retain, nonatomic) NSArray *photo;
@property (retain, nonatomic)  NSMutableDictionary *imgcash;
@property (assign, nonatomic) UIRefreshControl *refresh;
@property (assign, nonatomic) NSString *curpage;
@property (assign, nonatomic) NSString *maxpage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progresspage;


@end
