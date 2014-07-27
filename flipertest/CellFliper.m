//
//  CellFliper.m
//  flipertest
//
//  Created by CooLX on 16/07/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import "CellFliper.h"

@implementation CellFliper

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
