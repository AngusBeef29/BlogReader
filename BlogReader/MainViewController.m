//
//  MainViewController.m
//  BlogReader
//
//  Created by Geoffrey Angus on 9/8/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//

#import "MainViewController.h"
#import "Blog.h"
#import "TableViewController.h"
#import "CustomCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *blogURLs = [NSMutableArray array];
    
    [blogURLs addObject:@"http://friendly-encounters.blogspot.co.uk/feeds/posts/default?alt=json"];
    [blogURLs addObject:@"http://globaleconomicanalysis.blogspot.com/feeds/posts/default?alt=json"];
    [blogURLs addObject:@"http://www.calculatedriskblog.com/feeds/posts/default?alt=json"];
    [blogURLs addObject:@"http://hyperboleandahalf.blogspot.com/feeds/posts/default?alt=json"];

    
    NSError *error = nil;
    
    self.blogs = [NSMutableArray array];
    
    
    for (int i = 0; i < blogURLs.count; i++) {
        NSURL *targetURL = [NSURL URLWithString:[blogURLs objectAtIndex:i]];
        NSData *jsonData = [NSData dataWithContentsOfURL:targetURL];
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        NSDictionary *blogFeed = [dataDictionary objectForKey:@"feed"];
        
        Blog *blog = [Blog blogWithTitle:[[blogFeed objectForKey:@"title"] objectForKey:@"$t"]];
        
        blog.url = targetURL;
        blog.date = [[blogFeed objectForKey:@"updated"] objectForKey:@"$t"];
        blog.author = [[[[blogFeed objectForKey:@"author"] objectAtIndex:0] objectForKey:@"name"] objectForKey:@"$t"];
        
        [self.blogs addObject:blog];
        
    }
    
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.blogs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    NSLog(@"\nhere");
    
    Blog *blog = [self.blogs objectAtIndex:indexPath.row];
    
    if ([blog.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData  = [NSData dataWithContentsOfURL:blog.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        customCell.customImageView.image = image;
        
    }
    else {
        customCell.customImageView.image = [UIImage imageNamed:@"logo-small.png"];
    }
    
    customCell.customTitle.text = blog.title;
    customCell.customSubtitle.text = [NSString stringWithFormat:@"Updated: %@. %@",[blog formattedDate], blog.author];
    
    
    return customCell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showBlog"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Blog *blog = [self.blogs objectAtIndex:indexPath.row];
        TableViewController *tbc = (TableViewController *) segue.destinationViewController;
        tbc.blogURL = blog.url;
        tbc.title = blog.title;
        tbc.navigationItem.backBarButtonItem.title = @"Blogs";
    }
    
}
@end
