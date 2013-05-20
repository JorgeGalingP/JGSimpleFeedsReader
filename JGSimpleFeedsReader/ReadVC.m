//
//  ReadVC.m
//  JGSimpleFeedsReader
//
//  Created by Jorge Galindo Peña on 31/03/13.
//  Copyright (c) 2013 Jorge Galindo Peña. All rights reserved.
//

#import "ReadVC.h"

@interface ReadVC ()

@end

@implementation ReadVC
@synthesize url, webView;


- (id) initWithURL:(NSString *) linkURL andTitle:(NSString *) navTitle
{
    self = [super init];
    if (self) {
        url = linkURL;
        self.title = navTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    self.url = [self.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL *myUrl = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
    // Do any additional setup after loading the view.
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:myUrl]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
