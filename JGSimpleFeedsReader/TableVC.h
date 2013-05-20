//
//  MainTableVCViewController.h
//  JGSimpleFeedsReader
//
//  Created by Jorge Galindo Peña on 02/03/13.
//  Copyright (c) 2013 Jorge Galindo Peña. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMXMLParser.h"

@interface TableVC : UITableViewController <KMXMLParserDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *results;

@end
