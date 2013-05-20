//
//  MainTableVCViewController.m
//  JGSimpleFeedsReader
//
//  Created by Jorge Galindo Peña on 02/03/13.
//  Copyright (c) 2013 Jorge Galindo Peña. All rights reserved.
//

#import "TableVC.h"
#import "ReadVC.h"
#import "CustomCells.h"
#import "CustomCellsLarge.h"

#import "KMXMLParser.h"

#import "HTMLNode.h"
#import "HTMLParser.h"

#import "UIImageView+WebCache.h"

@interface TableVC ()

@end

@implementation NSString (mycategory)

- (NSString *)stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end

@implementation TableVC

@synthesize results = _results;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.title = @"News";

    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:@"http://cultofandroid.com.feedsportal.com/c/33880/f/612195/index.rss" delegate:self];
    
    self.results = [parser posts];

    [self stripHTMLFromSummary];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:nil action:@selector(reloadFeed) forControlEvents:UIControlEventAllEvents];
    
    [self.tableView registerClass:[CustomCells class] forCellReuseIdentifier:@"CellCustom"]; //CustomCell class
    [self.tableView registerClass:[CustomCellsLarge class] forCellReuseIdentifier:@"CellCustomLarge"]; //CustomCellLarge class
}

- (void) reloadFeed
{
    //NSAttributedString *refreshLB = [[NSAttributedString alloc] initWithString:@"Refreshing Table"];
    //self.refreshControl.attributedTitle = refreshLB;
    
    KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:@"http://cultofandroid.com.feedsportal.com/c/33880/f/612195/index.rss" delegate:self];
    
    self.results = [parser posts];
    
    [self stripHTMLFromSummary];
    
    [self performSelector:@selector(reloadTable) withObject:nil afterDelay:2.0];
}

- (void) reloadTable
{
    //NSAttributedString *refreshLB1 = [[NSAttributedString alloc] initWithString:@""];
    //self.refreshControl.attributedTitle = refreshLB1;
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)stripHTMLFromSummary {
    int i = 0;
    int count = self.results.count;
    
    while (i < count)
    {
        NSString *tempString = [[self.results objectAtIndex:i] objectForKey:@"summary"];
        NSMutableDictionary *dict = [self.results objectAtIndex:i];
        [dict setObject:tempString forKey:@"summary"];
        [self.results replaceObjectAtIndex:i withObject:dict];
        i++;
    }
}

-(NSURL*) getImageURLFromHTML: (NSString*) htmlSource {
    
    NSError *error = nil;
    
    htmlSource = [NSString stringWithFormat:@"<html>%@</html>", htmlSource];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlSource error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error);
        return nil;
    }

    HTMLNode *htmlNode = [parser doc];
    
    NSArray *inputNodes = [htmlNode findChildTags:@"img"];
    
    NSURL *returnURL = [[NSURL alloc] init];
    if (inputNodes.count > 0)
    {
        HTMLNode *inputNode = [inputNodes objectAtIndex:0];
        returnURL = [NSURL URLWithString:[inputNode getAttributeNamed:@"src"]];
    }
    return returnURL;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCustom";
    static NSString *CellIdentifierL = @"CellCustomLarge";
    
    NSString *source = [[NSString alloc] init];
    
    if (self.results) source = [NSString stringWithFormat:@"%@",[[self.results objectAtIndex:indexPath.row] objectForKey:@"summary"]];
        
    if (indexPath.row % 3 == 0)
    {
        CustomCellsLarge *cellL = [tableView dequeueReusableCellWithIdentifier:CellIdentifierL forIndexPath:indexPath];
        
        if (!cellL) cellL = [[CustomCellsLarge alloc] init];
        
        for (int x = 0; x<(indexPath.row + 1); x++)
        {
            NSMutableString *dateParsed = [[self.results objectAtIndex:indexPath.row] objectForKey:@"post"];
            [dateParsed replaceOccurrencesOfString:@"GMT" withString:@"" options:0 range:NSMakeRange(0, [dateParsed length])];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE, d MMM YYYY HH:mm:ss"];
            
            NSDate *date = [dateFormatter dateFromString:dateParsed];
            [dateFormatter setDateFormat:@"EEE, d MMM YYYY"];
            NSString *formatedDate = [dateFormatter stringFromDate:date];
            
            cellL.selectionStyle = UITableViewCellSelectionStyleNone;
        
            cellL.LBtitleLarge.text = [[self.results objectAtIndex:indexPath.row] objectForKey:@"title"];
            
            cellL.LBdateLarge.text = formatedDate;
            cellL.LBdateLarge.font = [UIFont fontWithName:@"Arial" size:13.0f];
            cellL.LBdateLarge.textColor = [UIColor whiteColor];
            cellL.LBdateLarge.highlightedTextColor = [UIColor blackColor];
            cellL.LBdateLarge.textAlignment = NSTextAlignmentLeft;
        
            [cellL.feedImageLarge setImageWithURL:[self getImageURLFromHTML:source]];
        }
        return cellL;
    }
    
    else
    {
        CustomCells *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (!cell) cell = [[CustomCells alloc] init];
        
        for (int x = 0; x<(indexPath.row + 1); x++)
        {
            NSMutableString *dateParsed = [[self.results objectAtIndex:indexPath.row] objectForKey:@"post"];
            [dateParsed replaceOccurrencesOfString:@"GMT" withString:@"" options:0 range:NSMakeRange(0, [dateParsed length])];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE, d MMM YYYY HH:mm:ss"];
            
            NSDate *date = [dateFormatter dateFromString:dateParsed];
            [dateFormatter setDateFormat:@"EEE, d MMM YYYY"];
            NSString *formatedDate = [dateFormatter stringFromDate:date];
            
            cell.LBtitle.text = [[self.results objectAtIndex:indexPath.row] objectForKey:@"title"];
            [cell.LBtitle setNumberOfLines:2];
            cell.LBtitle.lineBreakMode = NSLineBreakByTruncatingTail;
            [cell.LBtitle sizeToFit];
            [cell.LBtitle setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
            
            cell.LBsummary.text = formatedDate;
            cell.LBsummary.numberOfLines = 1;
            cell.LBsummary.font = [UIFont fontWithName:@"Arial" size:13.0f];
            cell.LBsummary.textColor = [UIColor grayColor];
            cell.LBsummary.highlightedTextColor = [UIColor blackColor];
            cell.LBsummary.textAlignment = NSTextAlignmentRight;
            
            [cell.feedImage setImageWithURL:[self getImageURLFromHTML:source]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;   
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 3 == 0) return 205.0f;
    
    return 85.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *link = [[self.results objectAtIndex:indexPath.row] objectForKey:@"link"];
    NSString *title = [[self.results objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    ReadVC *VC = [[ReadVC alloc] initWithURL:link andTitle:title];
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)parserDidFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse feed. Chech your network connection." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    [alert show];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"Error: %@", error);
}

- (void)parserCompletedSuccessfully
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"Parse complete. You may need to reload the table view to see the data.");
}

- (void)parserDidBegin
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSLog(@"Parsing has begun");
}

@end
