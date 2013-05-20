//
//  CustomCellsLarge.m
//  JGSimpleFeedsReader
//
//  Created by Jorge Galindo Peña on 19/03/13.
//  Copyright (c) 2013 Jorge Galindo Peña. All rights reserved.
//

#import "CustomCellsLarge.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomCellsLarge

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.LBtitleLarge = [[UILabel alloc] initWithFrame:CGRectMake(15, 162, 280, 32)];
        self.feedImageLarge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 205)];
        self.LBdateLarge = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 95, 10)];
        
        UIView *wallTime = [[UIView alloc] initWithFrame:CGRectMake(2.5, 15, 100, 20)];
        wallTime.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        wallTime.layer.cornerRadius = 10;
        
        UIView *wall = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 105)];
        wall.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = wall.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] CGColor],(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] CGColor], nil];
        [wall.layer insertSublayer:gradient atIndex:0];
        
        self.LBtitleLarge.numberOfLines = 1;
        self.LBtitleLarge.textColor = [UIColor whiteColor];
        self.LBtitleLarge.backgroundColor = [UIColor clearColor];
        
        self.LBdateLarge.numberOfLines = 1;
        self.LBdateLarge.textColor = [UIColor whiteColor];
        self.LBdateLarge.backgroundColor = [UIColor clearColor];
    
        [self.contentView addSubview:self.feedImageLarge];
        [self.contentView addSubview:wallTime];
        [self.contentView addSubview:wall];
        [self.contentView addSubview:self.LBdateLarge];
        [self.contentView addSubview:self.LBtitleLarge];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
