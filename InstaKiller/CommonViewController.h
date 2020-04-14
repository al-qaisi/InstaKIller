//
//  CommonViewController.h
//  InstaKiller
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VKSdk.h>
#import "DownloadHelper.h"

@interface CommonViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DownloadHelperDelegateCommon>

@property (weak, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, atomic) NSArray *posts;
@property (weak) VKUser *userInfo;

@end
