//
//  TableViewController.m
//  BlogReader
//
//  Created by Geoffrey Angus on 9/6/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//


#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"
#import "CustomCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:12.0],NSFontAttributeName, nil];
    NSLog(@"\ncurrent style: %@",self.navigationController.navigationBar.titleTextAttributes);
    self.navigationController.navigationBar.titleTextAttributes = size;
    NSLog(@"\nnew style: %@",self.navigationController.navigationBar.titleTextAttributes);
    
    
    NSLog(@"\n%@",self.blogURL);
    NSURL *blogURL = self.blogURL;
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.blogPosts = [NSMutableArray array];
    
    NSDictionary *blogPostFeed = [dataDictionary objectForKey:@"feed"];
    NSArray *blogPostEntries = [blogPostFeed objectForKey:@"entry"];
    NSMutableArray *blogPostTargets = [[NSMutableArray alloc] init];
    
    for (NSDictionary *bpEntryData in blogPostEntries) {
        NSArray *blogPostLinkArray = [bpEntryData objectForKey:@"link"];
        NSMutableDictionary *blogPostLink =[[NSMutableDictionary alloc] init];
        int index = 0;
        while (index < blogPostLinkArray.count) {
            NSDictionary *linkDictionary = blogPostLinkArray[index];
            if ([[linkDictionary objectForKey:@"rel"] isEqualToString:@"alternate"]) {
                [blogPostLink addEntriesFromDictionary:linkDictionary];
            }
            index++;
        }
        NSDictionary *blogPostDate = [bpEntryData objectForKey:@"updated"];
        NSDictionary *blogPostImage = [bpEntryData objectForKey:@"media$thumbnail"];
        NSMutableDictionary *blogPostData = [[NSMutableDictionary alloc] initWithDictionary:blogPostLink];
        [blogPostData setObject:[blogPostDate objectForKey:@"$t"] forKey:@"date"];
        if ([[blogPostImage objectForKey:@"url"] isKindOfClass:[NSString class]]) {
            [blogPostData setObject:[blogPostImage objectForKey:@"url"] forKey:@"image"];
        }
        [blogPostTargets addObject:blogPostData];
    }
    
    for (NSDictionary *bpDictionary in blogPostTargets) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
        blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"href"]];
        blogPost.author = @"Douglas Blane";
        blogPost.date = [bpDictionary objectForKey:@"date"];
        blogPost.thumbnail = [bpDictionary objectForKey: @"image"];
        [self.blogPosts addObject:blogPost];
    }
    
    //    for (NSDictionary *bpDictionary in blogPostsLinks) {
    //        BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
    //        blogPost.author = [bpDictionary objectForKey:@"author"];
    //        blogPost.thumbnail = [bpDictionary objectForKey:@"thumbnail"];
    //        blogPost.date = [bpDictionary objectForKey:@"date"];
    //        blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
    //        [self.blogPosts addObject:blogPost];
    //    }
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.blogPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData  = [NSData dataWithContentsOfURL:blogPost.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        customCell.customImageView.image = image;
        
    }
    else {
        customCell.customImageView.image = [UIImage imageNamed:@"logo-small.png"];
    }
    
    customCell.customTitle.text = blogPost.title;
    customCell.customSubtitle.text = [NSString stringWithFormat:@"%@",[blogPost formattedDate]];
    
    
    return customCell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
        WebViewController *wbc = (WebViewController *) segue.destinationViewController;
        wbc.blogPostURL = blogPost.url;
    }
    
}


@end
