//
//  Blog.h
//  BlogReader
//
//  Created by Geoffrey Angus on 9/8/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Blog : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSURL *url;

//Designated Initializer
- (id) initWithTitle:(NSString *)title;
+ (id) blogWithTitle:(NSString *)title;

- (NSURL *) thumbnailURL;
- (NSString *) formattedDate;

@end
