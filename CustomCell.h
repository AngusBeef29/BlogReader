//
//  CustomCell.h
//  BlogReader
//
//  Created by Geoffrey Angus on 9/8/15.
//  Copyright © 2015 Geoffrey Angus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customTitle;
@property (weak, nonatomic) IBOutlet UILabel *customSubtitle;
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end
