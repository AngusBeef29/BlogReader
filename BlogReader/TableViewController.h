//
//  TableViewController.h
//  BlogReader
//
//  Created by Geoffrey Angus on 9/6/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *blogPosts;
@property (strong, nonatomic) NSURL *blogURL;


@end
