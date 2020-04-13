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

@implementation CommonViewController

@synthesize userInfo;
@synthesize profilePhoto;
@synthesize fullNameLabel;
@synthesize cityLabel;
@synthesize birthDateLabel;
@synthesize tableView;

@synthesize posts;

- (void)viewDidLoad {
    
}

-(void)viewDidAppear:(BOOL)animated {
    NSString *fullName = [NSString stringWithFormat: @"%@ %@", userInfo.first_name, userInfo.last_name];
    fullNameLabel.text = fullName;
    
    cityLabel.text = (NSString *)userInfo.city; // nullable city
    birthDateLabel.text = userInfo.bdate;
    
    [profilePhoto setImageWithRemoteFileURL:userInfo.photo_200 placeholderImage:[UIImage imageNamed: @"default_profile_photo_200"]];
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
    WallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
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

@end
