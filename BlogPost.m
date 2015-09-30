//
//  BlogPost.m
//  BlogReader
//
//  Created by Geoffrey Angus on 9/6/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost

- (id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }
    return self;
}

+ (id) blogPostWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
    
    return [NSURL URLWithString:self.thumbnail];
}

- (NSString *) formattedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *tempDate = [dateFormatter dateFromString: [self.date substringToIndex:10]];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    return [dateFormatter stringFromDate:tempDate];
}



@end
