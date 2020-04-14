//
//  WallTableViewCell.m
//  InstaKiller
//
//  Created by user on 12.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "WallTableViewCell.h"
#import "UIImageViewExtended.h"
#import "DownloadHelper.h"
#import "VKModel.h"

@interface WallTableViewCell () {
    VKModel *vkModel;
}
@end
@implementation WallTableViewCell

@synthesize authorName;
@synthesize creationDate;
@synthesize postImage;
@synthesize postText;
@synthesize postData;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPostData:(NSDictionary*) data {
   
    //get post creator info
    postData = data;
    vkModel = [VKModel sharedInstance];
    NSLog(@"request user %@ info..", postData[@"owner_id"]);
    //set author name
    [vkModel requestUsersInfo:self withOwnerId: postData[@"owner_id"]];

    //form post date
    NSDate* postDate = [NSDate dateWithTimeIntervalSince1970: [(NSNumber *)postData[@"date"] doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    creationDate.text = [dateFormatter stringFromDate:postDate];
    
    //set post image
    NSDictionary *attachment = postData[@"attachments"][0];
   
    [postImage setImageWithRemoteFileURL: attachment[@"photo"][@"photo_604"] placeholderImage:[UIImage imageNamed:@"photos_refresh"]];
    
    //set text
    postText.text = postData[@"text"];
}

- (void) didCompleteDownloadForURL:(NSArray *)data {
    NSLog(@"set author fname ..");
    NSDictionary *creatorInfo = data[0][0];
    //form author full name
    NSString *fullName = [NSString stringWithFormat: @"%@ %@", creatorInfo[@"first_name"], creatorInfo[@"last_name"]];
    authorName.text = fullName;
}

@end
