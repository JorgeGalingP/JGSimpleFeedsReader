//
//  CustomCells.m
//  JGSimpleFeedsReader
//
//  Created by Jorge Galindo Peña on 02/03/13.
//  Copyright (c) 2013 Jorge Galindo Peña. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CustomCells.h"

@implementation CustomCells
{
    CALayer *_shadowLayer;
}

@synthesize LBsummary, LBtitle, feedImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellCustom"];
    if (self)
    {
        
        self.LBtitle = [[UILabel alloc] initWithFrame:CGRectMake(103, 11, 210, 53)];
        self.LBsummary = [[UILabel alloc] initWithFrame:CGRectMake(20, 63, 293, 17)];
        
        self.LBtitle.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.LBsummary.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        self.LBtitle.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.feedImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 75)];
        
        [self.contentView addSubview:self.LBtitle];
        [self.contentView addSubview:self.LBsummary];
        [self.contentView addSubview:self.feedImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
