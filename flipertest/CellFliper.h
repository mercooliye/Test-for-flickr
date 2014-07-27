//
//  CellFliper.h
//  flipertest
//
//  Created by CooLX on 16/07/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellFliper : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *titl;


@end
