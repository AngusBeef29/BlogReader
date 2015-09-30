//
//  WebViewController.h
//  BlogReader
//
//  Created by Geoffrey Angus on 9/6/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *blogPostURL;

@end
