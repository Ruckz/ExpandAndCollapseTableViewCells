//
//  ChildCell.m
//  PAC
//
//  Created by Ruckya Sinorina on 02/04/14.
//  Copyright (c) 2014 Mindster. All rights reserved.
//

#import "ChildCell.h"

@implementation ChildCell
@synthesize image,lab;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
