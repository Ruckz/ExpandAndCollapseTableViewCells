//
//  LetsTalkCustomCell.m
//  PAC
//
//  Created by Mindster on 12/19/13.
//  Copyright (c) 2013 Mindster. All rights reserved.
//

#import "LetsTalkCustomCell.h"

@implementation LetsTalkCustomCell
@synthesize lab,cat_image;
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
