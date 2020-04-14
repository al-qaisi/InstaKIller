//
//  CommonViewController.m
//  InstaKiller
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "CommonViewController.h"
#import "UIImageViewExtended.h"
#import "WallTableViewCell.h"
#import "VKModel.h"

@interface CommonViewController () {
        VKModel *vkModel;
}

@end

@implementation CommonViewController

@synthesize userInfo;
@synthesize profilePhoto;
@synthesize fullNameLabel;
@synthesize cityLabel;
@synthesize birthDateLabel;
@synthesize tableView;

@synthesize posts;

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(self) {
        vkModel = [VKModel sharedInstance];
        [vkModel requestWallPosts: self];
    }
    return self;
}


- (void)viewDidLoad {
    vkModel = [VKModel sharedInstance];
}


-(void)viewDidAppear:(BOOL)animated {
    //set labels text
    NSString *fullName = [NSString stringWithFormat: @"%@ %@", userInfo.first_name, userInfo.last_name];
    fullNameLabel.text = fullName;
    
    cityLabel.text = (NSString *)userInfo.city; // nullable city
    birthDateLabel.text = userInfo.bdate;
    
    //set profile photo image
    [profilePhoto setImageWithRemoteFileURL:userInfo.photo_200 placeholderImage:[UIImage imageNamed: @"default_profile_photo_200"]];
    
    //set wall data
    //posts = [vkModel requestWallPosts];
}


- (IBAction)onShowFriendsTouch:(id)sender {
}


- (IBAction)onShowGruopsTouch:(id)sender {
}


- (IBAction)onShowPhotosTouch:(id)sender {
    [super viewDidLoad];
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoCollectionViewController"];

    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    NSLog(@"generate cell..");
    WallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *postData = posts[indexPath.row];
    [cell setPostData:postData];
    
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark DownloadHelperDelegateCommon

- (void) didCompleteDownloadForURL:(NSArray *)data {
    NSLog(@"wall fetched, posts count: %lu", data.count);
    posts = data;
    [tableView reloadData];
}

@end
