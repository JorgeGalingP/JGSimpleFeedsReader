//
//  ReadVC.h
//  JGSimpleFeedsReader
//
//  Created by Jorge Galindo Peña on 31/03/13.
//  Copyright (c) 2013 Jorge Galindo Peña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadVC : UIViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIWebView *webView;

- (id) initWithURL:(NSString *) linkURL andTitle:(NSString *) navTitle;

@end
