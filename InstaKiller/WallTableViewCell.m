//
//  WallTableViewCell.m
//  InstaKiller
//
//  Created by user on 12.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "WallTableViewCell.h"

@implementation WallTableViewCell

@synthesize authorName;
@synthesize creationDate;
@synthesize postImage;
@synthesize postText;


- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    authorName.text = @"Igor Postoev";
    creationDate.text = @"12:00 14.03.12";
    postImage.image = [UIImage imageNamed:@"man"];
    postText.text = @"Hello, this is the post of mine";
}

@end
